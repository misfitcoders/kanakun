//
//  GameContentController.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 22/07/2020.
//

import Foundation
import SwiftUI
import Combine
import CoreData
import jisho_swift
import wanakana_swift

class PlayObject: Identifiable {
    var id = UUID()
    var jishoContent: JishoEntry
    var playContent: String
    var played = false
    var failed = 0
    
    init(_ entry: JishoEntry) {
        self.jishoContent = entry
        playContent = entry.japanese.first!.reading!
    }
}

class GameContentController: ObservableObject {
    @Published var content: [PlayObject]
    var index: Int
    var gamePlay = GamePlayController.game
    
    func next() {
        if index >= content.count - 1 { index = 0 }
        else { index += 1 }
        let playString = content[index].playContent
        if playString.count > 15 {
            next()
            return
        }
        print("playing with: \(content[index].playContent)")
        gamePlay.startGameWith(
            content: playString.tokenizedAll
        )
    }
    
    var cancellables = [AnyCancellable]()
    
    init() {
        self.content = []
        self.index = 0
        
        guard let result = try? Jisho.searchFor(
                term: .Proverb, page: 1)
        else { return }

        print("init Game content controller!")
        cancellables.append(
            result.sink(
                receiveCompletion: { print($0) }) { jishoResult in
                self.content = jishoResult.data
                    .map({ entry in PlayObject(entry) })
                print("playing with: \(self.content[self.index].playContent)")
                
                self.gamePlay.startGameWith(
                    content: self.content[self.index]
                        .playContent
                        .tokenizedAll
                )
            }
        )
    }
}
