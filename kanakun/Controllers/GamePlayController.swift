//
//  GamePlayController.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 18/07/2020.
//

import Foundation
import Combine
import jisho_swift

enum GameMode {
    case Hira_Kata
    case Hira_Roma
    case Kata_Hira
    case Kata_Roma
    case Roma_Hira
    case Roma_Kata
}


final class GamePlayController: ObservableObject {
    
    private init() { }
    static let game = GamePlayController()
    
    
    @Published var content = [FuriganaEntry]()
    @Published var cursor = (index: 0, character: 0)
    @Published var mode: GameMode = GameMode.Hira_Kata
    /// Returns true if player has succeeded and the game has ended
    @Published var success: Bool = false
    /// Returns the count of failed attempts in the current game
    @Published var failed: Int = 0
    @Published var padItems = [Character]()

    /// The current content item in play
    var current: FuriganaEntry? {
        if content.isEmpty { return nil }
        else { return content[cursor.index] }
    }

    /// The current character in play
    var currentCharacter: Character? {
        current?.hiragana[cursor.character]
    }
    
    /// All characters in play
    var allCharacters: String {
        if content.isEmpty { return "" }
        return content.reduce(into: "") { result, entry in
            result += entry.hiragana
        }
    }

    /// Computes the game pad array for the given content
    func generatePadItems(slots: Int = 25) -> [Character] {
        if content.isEmpty { return [] }
        var uniques = allCharacters.uniques
        if uniques.count > slots { return [] }
        var counter = 0
        while uniques.count < slots {
            if !uniques.contains(allHiragana[counter]) {
                uniques.append(allHiragana[counter])
            } else {
                counter += 1
            }
        }
        return uniques
    }
    
    /// Checks the input against the current furigana item
    func checkAnswer(forInput input: String) {
        if current == nil { return }
        if input.first == currentCharacter { next() }
        else { failed += 1 }
    }
    
    /// Move cursor to next step. If last, set the game as done
    func next() {
        if cursor.character + 1 >= current!.hiragana.count {
            // reset character
            cursor.character = 0
            // set the game done if this was the last character
            if cursor.index + 1 >= content.count { success = true }
            // move index to the next content item
            else { cursor.index += 1 }
        }
        // move cursor to the next character in index
        else { cursor.character += 1 }
    }
    
    /// Clears the game to nothing
    func clearGame() {
        content = []
        resetGame()
    }
    
    /// Restarts the game with the currently available content
    func resetGame() {
        cursor.index = 0
        cursor.character = 0
        failed = 0
        success = false
        padItems = []
        padItems = generatePadItems()
    }
    
    func startGameWith(content data: [FuriganaEntry]) {
        content = data
        resetGame()
    }
    
}
