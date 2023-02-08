//
//  MutableCollection+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 12/12/2017.
//

import UIKit

public extension MutableCollection where Index == Int {

	mutating func shuffle() {
		guard count > 1 else { return }

		for i in startIndex ..< endIndex - 1 {
			let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
			if i != j {
				self.swapAt(i, j)
			}
		}
	}

	func random() -> Element? {
		guard !isEmpty else { return nil }
		return self[Int(arc4random_uniform(UInt32(endIndex)))]
	}

}

public extension MutableCollection where Element == CGFloat {

    func findClosestValue(to: Element) -> Element? {
        if self.isEmpty { return nil }

        var minDiff = CGFloat.greatestFiniteMagnitude
        var minValue = CGFloat(0.0)
        self.forEach {
            let diff = Swift.min(minDiff, abs($0 - to))
            if diff < minDiff {
                minDiff = diff
                minValue = $0
            }
        }
        return minValue
    }

}

public extension MutableCollection {

    func multiplied<SecondElement>(by secondArray: [SecondElement]) -> [(Element, SecondElement)] {
        var resultCollection: [(Element, SecondElement)] = []
        self.forEach { element in
            secondArray.forEach { secondElement in
                resultCollection.append((element, secondElement))
            }
        }
        return resultCollection
    }

}

public extension CollectionDifference.Change {

    var offset: Int {
        switch self {
        case let .insert(offset, _, _): return offset
        case let .remove(offset, _, _): return offset
        }
    }

    var element: ChangeElement {
        switch self {
        case let .insert(_, element, _): return element
        case let .remove(_, element, _): return element
        }
    }

    var associatedWith: Int? {
        switch self {
        case let .insert(_, _, associatedWith): return associatedWith
        case let .remove(_, _, associatedWith): return associatedWith
        }
    }

}
