//
//  GameIndicator.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 18/07/2020.
//

import SwiftUI
import Combine
import jisho_swift
import wanakana_swift

struct GameIndicator: View {
    
    var content: [EnumeratedToken]
    var cursor: Int
    
    var chunkedContentBlocks: [[EnumeratedToken]] {
        content.count <= 5
            ? [content]
            : content.chunked(into: 5)
    }
    
    func kanaViewBlock(_ enumeratedToken: EnumeratedToken) -> AnyView {
        return AnyView(
            VStack{
                Text(enumeratedToken.viewIndicator)
                    .font(.system(size: 43))
                    .fontWeight(.bold)
                    .foregroundColor(enumeratedToken.index > cursor
                                        ? .Astronaut
                                        : .BonJour
                    )
                    .padding(.all, 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(
                                Color.Astronaut,
                                lineWidth: enumeratedToken.index == cursor
                                    ? 3
                                    : 0
                            )
                    )
            }
        )
    }
    
    var body: some View {
        GeometryReader { geometry in
                VStack {
                    ForEach(chunkedContentBlocks, id: \.self) { row in
                        HStack(
                            alignment: VerticalAlignment.bottom,
                            spacing: 5,
                            content: {
                                ForEach(row, id: \.self)
                                    { kanaViewBlock($0) }
                            }
                        )
                    }
                }
                .padding(.all, 20)
                .background(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                Color.PersianPink,
                                Color.FrenchRose
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(13.0)
                .frame(width: geometry.size.width)

        }
        .frame(height: CGFloat(73 * chunkedContentBlocks.count))
    }
}

struct GameIndicator_Previews: PreviewProvider {
    static var previews: some View {
        GameIndicator(content:
                        "てんもうかいかいそにしてもらさ"
                        .tokenizedAll
                        .enumerated()
                        .map {
                            EnumeratedToken(
                                index: $0.offset,
                                token: $0.element,
                                mode: GameViewMode.Roma_Kata
                            )
                        }
            , cursor: 0)
    }
}
