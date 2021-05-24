//
//  CaseIterable.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 23/07/2020.
//

import Foundation

extension CaseIterable where Self: Equatable {
    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
}
