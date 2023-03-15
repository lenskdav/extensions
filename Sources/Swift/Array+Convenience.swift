//
//  Array+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 08/03/2020.
//  Copyright © 2020 David Lenský. All rights reserved.
//

import Foundation

/*✻**********************************************************************/
// MARK: - Init Extensions
/*✻**********************************************************************/

public extension Array {

    init(withCapacity: Int) {
        self.init()
        self.reserveCapacity(capacity)
    }

}

/*✻**********************************************************************/
// MARK: - Convenience Extensions
/*✻**********************************************************************/

public extension Array {

    var isNotEmpty: Bool { isEmpty.not }

}

/*✻**********************************************************************/
// MARK: - Mutating Function Extensions
/*✻**********************************************************************/

public extension Array {

    mutating func move(from fromIndex: Array.Index, to toIndex: Array.Index) {
        let element: Element = self.remove(at: fromIndex)
        self.insert(element, at: toIndex)
    }

    mutating func move(from fromIndices: [Array.Index], to toIndex: Array.Index) {
        var result: [Array.Element] = Array(withCapacity: self.count)
        for i in 0..<self.count {
            if fromIndices.contains(i) { continue }
            if i == toIndex {
                for index in fromIndices { result.append(self[index]) }
                continue
            }
            
            result.append(self[i])
        }
        
        self = result
    }

    mutating func dropFirst(where closure: (Element) -> Bool) -> Element? {
        guard let index = self.firstIndex(where: closure) else { return nil }
        let element = self[index]
        remove(at: index)
        return element
    }

}

/*✻**********************************************************************/
// MARK: - Function Extensions
/*✻**********************************************************************/

public extension Array {

    func first<Value: Equatable>(_ keypath: KeyPath<Element, Value>, _ value: Value) -> Element? {
        first { element -> Bool in element[keyPath: keypath] == value }
    }

    func first<Value: Equatable>(_ keypath: KeyPath<Element, Value>, _ value: Value?) -> Element? {
        first { element -> Bool in element[keyPath: keypath] == value }
    }

    func first<Value: Equatable>(_ keypath: KeyPath<Element, Value?>, _ value: Value) -> Element? {
        first { element -> Bool in element[keyPath: keypath] == value }
    }

    func first(_ keypath: KeyPath<Element, Bool>) -> Element? {
        first { element -> Bool in element[keyPath: keypath] }
    }

    func firstIndex<Value: Equatable>(_ keypath: KeyPath<Element, Value>, _ value: Value) -> Array<Element>.Index? {
        firstIndex { element -> Bool in element[keyPath: keypath] == value }
    }

    func filter<Value: Equatable>(_ keypath: KeyPath<Element, Value>, _ value: Value) -> [Element] {
        filter { element -> Bool in element[keyPath: keypath] == value }
    }
    
    func filterNil<ClosureResult>(_ closure: @escaping (Element) -> ClosureResult?) -> [Element] {
        filter { closure($0) != nil }
    }

    func filter<Value: Equatable>(_ array: [Value], contains keypath: KeyPath<Element, Value>) -> [Element] {
        filter { element -> Bool in array.contains(element[keyPath: keypath]) }
    }
	
	func filterOut(_ isNotIncluded: (Element) throws -> Bool) rethrows -> [Element] {
		try filter { try !isNotIncluded($0) }
	}

    func filterOut<Value: Equatable>(_ keypath: KeyPath<Element, Value>, _ value: Value) -> [Element] {
        filter { element -> Bool in element[keyPath: keypath] != value }
    }

    func filterOut<Value: Equatable>(_ keypath: KeyPath<Element, Value>, _ value: Value?) -> [Element] {
        filter { element -> Bool in element[keyPath: keypath] != value }
    }

    func filterOut<Value: Equatable>(_ array: [Value], contains keypath: KeyPath<Element, Value>) -> [Element] {
        filter { element -> Bool in !array.contains(element[keyPath: keypath]) }
    }

    func `do`(_ body: (Element) throws -> Void) rethrows -> [Element] {
        try forEach(body)
        return self
    }

    func allSatisfy<Value: Equatable>(_ keyPath: KeyPath<Element, Value>, _ value: Value) -> Bool {
        allSatisfy { $0[keyPath: keyPath] == value }
    }

    func allDissatisfy<Value: Equatable>(_ keyPath: KeyPath<Element, Value>, _ value: Value) -> Bool {
        allSatisfy { $0[keyPath: keyPath] != value }
    }

    func sum<Result: Numeric>(_ initialResult: Result, _ keyPath: KeyPath<Element, Result>) -> Result {
        reduce(initialResult) { result, element in
            result + element[keyPath: keyPath]
        }
    }

}

/*✻**********************************************************************/
// MARK: - Hashable Extensions
/*✻**********************************************************************/

public extension Array where Element: Hashable {

    var set: Set<Element> {
        Set(self)
    }

    var unique: Self {
        self.set.array
    }

    func isIdentical(to: [Element]) -> Bool {
        difference(from: to).isEmpty
    }

    func filterOut(_ element: Element?) -> [Element] {
        filter { $0 != element }
    }

    // I know it looks like shit, but it has great benchmark results :D 
    func insertBetweenEach(_ element: Element) -> [Element] {
        guard count > 1 else { return self }
        return (0 ..< 2 * count - 1).map { $0 % 2 == 0 ? self[$0/2] : element }
    }

}

/*✻**********************************************************************/
// MARK: - Helper Extensions
/*✻**********************************************************************/

public extension ArraySlice {

    var array: [Element] {
        Array(self)
    }

}

/*✻**********************************************************************/
// MARK: - Grouped
/*✻**********************************************************************/

extension Array {

    func grouped<Key: Hashable>(by keyPath: KeyPath<Element, Key>) -> Dictionary<Key, [Element]> {
        Dictionary(grouping: self) { $0[keyPath: keyPath] }
    }

}
