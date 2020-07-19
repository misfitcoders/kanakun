//
//  String.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 18/07/2020.
//

import Foundation

extension String {
    var uniques: Array<Character> {
        var buffer = Array<Character>()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}


extension StringProtocol {
    subscript(_ offset: Int)                     -> Element     { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>)               -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>)         -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>)    -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>)    -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}

/*
let test = "Hello USA 🇺🇸!!! Hello Brazil 🇧🇷!!!"
test[safe: 10]   // "🇺🇸"
test[11]   // "!"
test[10...]   // "🇺🇸!!! Hello Brazil 🇧🇷!!!"
test[10..<12]   // "🇺🇸!"
test[10...12]   // "🇺🇸!!"
test[...10]   // "Hello USA 🇺🇸"
test[..<10]   // "Hello USA "
test.first   // "H"
test.last    // "!"

// Subscripting the Substring
 test[...][...3]  // "Hell"

// Note that they all return a Substring of the original String.
// To create a new String from a substring
test[10...].string  // "🇺🇸!!! Hello Brazil 🇧🇷!!!"
*/
