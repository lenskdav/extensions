//
//  Collection+Convenience.swift
//  Extensions
//
//  Created by Daniel Arden on 23.10.2021.
//

public extension Collection {


    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

}

public extension Collection where Element: Equatable {

    func next(after element: Element) -> Element? {
        guard let currentIndex = firstIndex(where: { $0 == element }) else { return nil }
        let nextIndex = index(after: currentIndex)

        return self[safe: nextIndex]
    }

}

public extension Collection {

    func min<C: Comparable>(by keyPath: KeyPath<Element, C>) -> Element? {
        self.min { first, second in
            first[keyPath: keyPath] < second[keyPath: keyPath]
        }
    }

    func max<C: Comparable>(by keyPath: KeyPath<Element, C>) -> Element? {
        self.max { first, second in
            first[keyPath: keyPath] < second[keyPath: keyPath]
        }
    }

}
