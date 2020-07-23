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
        GeometryReader { geometry in VStack {
            ForEach(padItems.chunked(into: 5), id: \.self) { padRow in
                HStack {
                    ForEach(padRow, id: \.self) { item in
                        Button(
                            action: { checkAnswer(item.token.hiragana) }
                        ) {
                            Text(String(item.viewGamePad))
                                .font(.system(size: 30))
                                .fontWeight(.heavy)
                                .foregroundColor(.Turquoise)
                                .frame(
                                    width: (geometry.size.width / 5) - 10,
                                    height:  (geometry.size.width / 5),
                                    alignment: .center
                                )
                            }
                        }
                    }
                    .frame(width: geometry.size.width, alignment: .center)
                }
            }
        }
    }
}

struct GamePad_Previews: PreviewProvider {
    static var previews: some View {
        GamePad(
            padItems: "いすかんきくまなもみこひゃさつぬふあうえおやゆきょれわ".tokenizedAll
                .enumerated()
                .map {
                    EnumeratedToken(
                        index: $0.offset,
                        token: $0.element,
                        mode: GameViewMode.Roma_Kata
                    )
                },
            checkAnswer: { print($0) })
    }
}
