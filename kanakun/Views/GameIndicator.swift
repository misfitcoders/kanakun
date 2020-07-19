//
//  GameIndicator.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 18/07/2020.
//

import SwiftUI
import Combine
import jisho_swift

struct GameIndicator: View {
    
    var content: [FuriganaEntry]
    var cursor: (index: Int, character: Int)
    
    func furiganaViewBlock(_ entry: FuriganaEntry) -> AnyView {
        return AnyView(
            VStack{
                Text(
                    entry.original == entry.hiragana ||
                    entry.original == entry.katakana
                        ? "" // no furigana to show
                        : entry.hiragana
                )
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(.Astronaut)
                Text(entry.original)
                    .font(.system(size: 48))
                    .fontWeight(.bold)
                    .foregroundColor(.Astronaut)
            }
        )
    }
    
    var body: some View {
        GeometryReader {geometry in
            VStack {
                ForEach(content.chunked(into: 6), id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self)
                        { entry in furiganaViewBlock(entry) }
                    }
                }
        }
        .frame(
            width: geometry.size.width - 40,
            height: ((geometry.size.width - 20)/4)*2,
            alignment: .center
        )
        .background(
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color.PersianPink,
                        Color.FrenchRose]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .cornerRadius(13.0)}
    }
}

//struct GameIndicator_Previews: PreviewProvider {
//    static var previews: some View {
//        GameIndicator(content: [
//        FuriganaEntry(original: "私", hiragana: "わたし", katakana: "ワタシ", romaji: "watashi"),
//
//        ])
//    }
//}
