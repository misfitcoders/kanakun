//
//  GamePad.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 18/07/2020.
//

import SwiftUI
import Combine
import jisho_swift
import wanakana_swift

struct GamePad: View {
    
    var padItems: [EnumeratedToken]
    var checkAnswer: (_ forInput: String) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ForEach(self.padItems.chunked(into: 5), id: \.self) { padRow in
                    HStack (spacing: 0) {
                        ForEach(padRow, id: \.self) { item in
                            Button(
                                action: { self.checkAnswer(item.token.hiragana) }
                            ) {
                                Text(String(item.viewGamePad))
                                    
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                    .foregroundColor(.LightSlateGrey)
                                    .frame(
                                        width: geometry.size.width / 5,
                                        height:  geometry.size.width / 5,
                                        alignment: .center
                                )
                                    .animation(
                                        .spring(
                                            response: 0.5,
                                            dampingFraction: 2,
                                            blendDuration: 0.5
                                        )
                                )
                            }
                        .overlay(
                            Rectangle()
                                .fill(Color.white.opacity(0))
                                .border(width: 2, edge: .leading, color: Color.Geyser.opacity(0.7))
                                .border(width: 2, edge: .trailing, color: Color.white.opacity(0.4))
                                .border(width: 2, edge: .bottom, color: Color.Geyser.opacity(0.7))
                                .border(width: 2, edge: .top, color: Color.white.opacity(0.4))
                            )
                        }
                    }
                }
            }
            .overlay(
              Rectangle()
                .strokeBorder(
                    LinearGradient.DiagonalDarkBorder,
                    lineWidth: 1.5
                )
            )
              .background(Color.Glitter)
              .shadow(
                color: Color(white: 1.0).opacity(0.9),
                radius: 18, x: -18, y: -18
            )
              .shadow(
                color: Color.Manatee.opacity(0.5),
                radius: 14, x: 14, y: 14
            )
        }
    }
}

struct GamePad_Previews: PreviewProvider {

    static var previews: some View {
        ZStack {
            Color.Glitter.edgesIgnoringSafeArea(.all)
            GamePad(
                padItems: "いすかんきくまなもみこひゃさつぬふあうえおやゆきょれわ"
                    .tokenizedAll
                    .enumerated()
                    .map {
                        EnumeratedToken(
                            index: $0.offset,
                            token: $0.element,
                            mode: GameViewMode.Kata_Roma
                        )
                    },
            checkAnswer: { print($0) })
        }
        
    }
}
