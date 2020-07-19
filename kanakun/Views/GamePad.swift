//
//  GamePad.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 18/07/2020.
//

import SwiftUI
import Combine
import jisho_swift

struct GamePad: View {
    
    @ObservedObject var gamePlay = GamePlayController.game

    var body: some View {
        GeometryReader { geometry in VStack {
            ForEach(gamePlay.padItems.chunked(into: 5), id: \.self) { padRow in
                HStack {
                    ForEach(padRow, id: \.self) { item in
                        Button(action: {
                            gamePlay.checkAnswer(
                                forInput: String(item))
                        }) {
                            Text(String(item))
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.Turquoise)
                                .frame(
                                    width: (geometry.size.width / 5) - 10,
                                    height:  (geometry.size.width / 5) - 10,
                                    alignment: .center
                                )
                        }
                    }
                }
                .padding(.bottom, 10)
            }
        }}
    }
}

struct GamePad_Previews: PreviewProvider {
    static var previews: some View {
        GamePad()
    }
}
