//
//  Dictionary+Convenience.swift
//  Extensions
//
//  Created by David Lensky on 17/07/2018.
//

import Foundation

public extension Dictionary {

    var isNotEmpty: Bool { isEmpty.not }

}

public extension Dictionary {

    func mapKeyValue<K, V>(_ transform: ((key: Key, value: Value)) throws -> (K, V) ) rethrows -> [K: V] {
        var newDictionary: [K: V] = [:]
        for (key, value) in self {
            let newTuple = try transform((key: key, value: value))
            newDictionary[newTuple.0] = newTuple.1
        }
        return newDictionary
    }

    func compactMapKeyValue<K, V>(_ transform: ((key: Key, value: Value)) throws -> (K, V)? ) rethrows -> [K: V] {
        var newDictionary: [K: V] = [:]
        for (key, value) in self {
            guard let newTuple = try transform((key: key, value: value)) else { continue }
            newDictionary[newTuple.0] = newTuple.1
        }
        return newDictionary
    }

}

public extension Dictionary where Key == ClosedRange<Int> {

    subscript(_ number: Int) -> Value? {
        guard let key = self.keys.first(where: { $0 ~= number }) else { return nil }
        return self[key]
    }

}

public extension Dictionary.Keys {

    var array: [Element] { return self.filter { _ in true } }

}

public extension Dictionary.Values {

    var array: [Element] { return self.filter { _ in true } }

}

public extension Array {

    func mapToDict<K, V>(_ transform: (Element) throws -> (K, V) ) rethrows -> [K: V] {
        var newDictionary: [K: V] = [:]
        for element in self {
            let newTuple = try transform(element)
            newDictionary[newTuple.0] = newTuple.1
        }
        return newDictionary
    }

    func compactMapToDict<K, V>(_ transform: (Element) throws -> (K, V)? ) rethrows -> [K: V] {
        var newDictionary: [K: V] = [:]
        for element in self {
            guard let newTuple = try transform(element) else { continue }
            newDictionary[newTuple.0] = newTuple.1
        }
        return newDictionary
    }

    func compactMapToDict<K, V>(_ transform: (Element) throws -> (K, V?) ) rethrows -> [K: V] {
        var newDictionary: [K: V] = [:]
        for element in self {
            let newTuple = try transform(element)
            guard newTuple.1 != nil else { continue }
            newDictionary[newTuple.0] = newTuple.1
        }
        return newDictionary
    }

    var dictionary: [Int: Element] {
        var newDict: [Int: Element] = [:]
        for i in 0..<self.count {
            newDict[i] = self[i]
        }
        return newDict
    }

}

public extension Dictionary {

    var elements: [(Key, Value)] {
        map { key, value in (key, value) }
    }

    func groupValues<NewKey>(by keyForPair: ((key: Key, value: Value)) throws -> NewKey) rethrows -> [NewKey: [Value]] {
        var newDictionary: [NewKey: [Value]] = [:]
        try forEach { key, value in
            let newKey = try keyForPair((key: key, value: value))

            if newDictionary.keys.contains(newKey) {
                newDictionary[newKey]?.append(value)
            } else {
                newDictionary[newKey] = [value]
            }
        }
        return newDictionary
    }
    
    func toJSONString() -> String {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else { return "" }
        return String(data: jsonData, encoding: .utf8) ?? ""
    }
    
}

