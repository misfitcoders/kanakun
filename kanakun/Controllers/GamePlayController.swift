//
//  GamePlayController.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 18/07/2020.
//

import Foundation
import Combine
import jisho_swift
import wanakana_swift

final class GamePlayController: ObservableObject {
    
    private init() { }
    static let game = GamePlayController()
    
    
    @Published var content = [Tokenized]()
    @Published var cursor = 0
    @Published var mode: GameViewMode = GameViewMode.Hira_Roma
    /// Returns true if player has succeeded and the game has ended
    @Published var success: Bool = false
    /// Returns the count of failed attempts in the current game
    @Published var failed: Int = 0
    @Published var padItems = [Tokenized]()
    
    /// The current content item in play
    var current: Tokenized? {
        if content.isEmpty { return nil }
        else { return content[cursor] }
    }

    /// The current character in play (in hiragana)
//    var currentCharacter: String? {
//        current?.hiragana
//    }
    
    /// All characters in playing content
    var allCharacters: [String] {
        if content.isEmpty { return [] }
        return content.reduce(into: [String]()) { result, entry in
            result.append(entry.hiragana)
        }
    }
    
    /// All cancelables generated to start a new game
    var cancellables = [AnyCancellable]()

    /// Computes the game pad array for the given content
    /// - Parameter slots: how many items the pad must have (default: 25)
    /// - Returns: An array the length specified in **slots** of tokenized kana and romaji
    func generatePadItems(slots: Int = 25) -> [Tokenized] {
        if content.isEmpty { return [] }
        var uniques = allCharacters.uniques
        if uniques.count > slots { return [] }
        var counter = 0
        while uniques.count < slots {
            if !uniques.contains(String(allHiragana[counter])) {
                uniques.append(String(allHiragana[counter]))
            } else {
                counter += 1
            }
        }
        return uniques
            .shuffled()
            .reduce(into: "") { $0 += $1 }
            .tokenizedAll
    }

    /// Checks the input against the current item in play (in Hiragana)
    /// - Parameter input: The string to check against for (checks are performed in Hiragana only)
    func checkAnswer(_ input: String) {
        if current == nil { return }
        if input == current?.hiragana { next() }
        else { failed += 1 }
    }
    
    /// Move cursor to next step. If last, set the game as done
    func next() {
        if cursor + 1 >= content.count {
            // set the game done if this was the last character
             success = true
        }
        // move cursor to the next character in index
        else { cursor += 1 }
    }
    
    func toggleMode() {
        mode = mode.next()
    }
    
    /// Clears the game to nothing
    func clearGame() {
        content = []
        resetGame()
    }
    
    /// Restarts the game with the currently available content
    func resetGame() {
        DispatchQueue.main.async {
            self.cursor = 0
            self.failed = 0
            self.success = false
            self.padItems = []
            self.padItems = self.generatePadItems()
        }
    }
    
    /// Starts a new game with the tokenized received data
    func startGameWith(content data: [Tokenized]) {
        DispatchQueue.main.async {
            self.content = data
            self.resetGame()
            self.cancellables = []
        }
    }
    
}
