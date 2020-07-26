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
    
    var previousFailure = 0
    var failure: Int
    
    var chunkedContentBlocks: [[EnumeratedToken]] {
        switch content.count {
            case ..<5: return [content]
            case 6...15: return content.chunked(into: 5)
            case 15...: return content.chunked(into: 7)
            default: return content.chunked(into: 7)
        }

    }
    
    var fontSize: CGFloat {
        switch chunkedContentBlocks.count {
            case 3...4: return 34
            case 4...: return 24
            default: return 40
        }
    }
    
    var heightSize: CGFloat {
        switch chunkedContentBlocks.count {
            case 1...3: return CGFloat(chunkedContentBlocks.count * 67)
            case 4... : return CGFloat(chunkedContentBlocks.count * 60)
            default   : return CGFloat(chunkedContentBlocks.count * 63)
        }
    }
    
    func kanaViewBlock(_ enumeratedToken: EnumeratedToken) -> AnyView {
        return AnyView(
            VStack{
                Text(enumeratedToken.viewIndicator)
                    .font(.system( size: fontSize ))
                    .fontWeight(.bold)
                    .foregroundColor(enumeratedToken.index > cursor
                                        ? .LightSlateGrey
                        :  enumeratedToken.index == cursor && self.previousFailure < failure ? .red : .Madison
                    )
                    .padding(.all, 4)
//                    .overlay(
//                        Rectangle()
//                            .fill(Color.white.opacity(0))
//                            .border(width: 2, edge: .bottom, color: Color.Geyser.opacity(enumeratedToken.index == cursor ? 0.7 : 0))
//
//                        .shadow(color: .white, radius: 4, x: -2, y: -2)
//                        .shadow(color: .Manatee, radius: 4, x: 2, y: 2)
//                    )
               
            }
        )
    }
    
    var body: some View {
        GeometryReader { geometry in
                VStack {
                    ForEach(self.chunkedContentBlocks, id: \.self) { row in
                        HStack(
                            alignment: VerticalAlignment.bottom,
                            spacing: 5,
                            content: {
                                ForEach(row, id: \.self)
                                { self.kanaViewBlock($0) }
                            }
                        )
                    }
                }
                .padding(.all, 20)

        }
        .frame(height: CGFloat(heightSize))
    }
}

struct GameIndicator_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameIndicator(content:
                            "てんもうかいかいそにしてもらさ"
                            .tokenizedAll
                            .enumerated()
                            .map {
                                EnumeratedToken(
                                    index: $0.offset,
                                    token: $0.element,
                                    mode: GameViewMode.Kata_Roma
                                )
                            }
                , cursor: 0, failure: 0)
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDisplayName("Regular Entry")
            GameIndicator(content:
                            "てんもうかいかいそにしてもらさかんな"
                            .tokenizedAll
                            .enumerated()
                            .map {
                                EnumeratedToken(
                                    index: $0.offset,
                                    token: $0.element,
                                    mode: GameViewMode.Hira_Roma
                                )
                            }
                , cursor: 5, failure: 1)
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDisplayName("Overflown 1 (3...4)")
            GameIndicator(content:
                            "てんもうかいかいそにしてもらさかんなちとしはきくまつさ"
                            .tokenizedAll
                            .enumerated()
                            .map {
                                EnumeratedToken(
                                    index: $0.offset,
                                    token: $0.element,
                                    mode: GameViewMode.Kata_Roma
                                )
                            }
                , cursor: 0, failure: 0)
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDisplayName("Overflown 1 (4...)")
        }
    }
}
