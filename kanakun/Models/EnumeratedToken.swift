//
//  EnumeratedToken.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 23/07/2020.
//

import Foundation
import wanakana_swift

struct EnumeratedToken: Identifiable, Hashable {
    let id = UUID()
    var index: Int
    var token: Tokenized
    var mode: GameViewMode
    
    var viewIndicator: String {
        switch mode {
        case .Hira_Kata, .Hira_Roma:
            return token.hiragana
        case .Kata_Hira, .Kata_Roma:
            return token.katakana
        case .Roma_Hira, .Roma_Kata:
            return token.romaji
        }
    }
    var viewGamePad: String {
        switch mode {
        case .Roma_Hira, .Kata_Hira:
            return token.hiragana
        case .Roma_Kata, .Hira_Kata:
            return token.katakana
        case .Kata_Roma, .Hira_Roma:
            return token.romaji
        }
    }
    
    init(
        index: Int,
        token: Tokenized,
        mode: GameViewMode = GameViewMode.Hira_Roma
    ) {
        self.index = index
        self.token = token
        self.mode = mode
    }
}
