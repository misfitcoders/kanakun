enum Mode: CaseIterable {
    case one
    case two
    case three
    case four
}

extension CaseIterable where Self: Equatable {
    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
}

func nextMode(of from: Mode) -> Mode {
    from.next()
}

print(nextMode(of: .one))
print(nextMode(of: .three))
print(nextMode(of: .four))
