//
//  GameViewMode.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 23/07/2020.
//

import Foundation

public enum GameViewMode: CaseIterable {
    case Hira_Kata
    case Hira_Roma
    case Kata_Hira
    case Kata_Roma
    case Roma_Hira
    case Roma_Kata
}

public enum GameContentMode {
    case available
    case failed
}
