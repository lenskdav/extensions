//
//  AnyObserver+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 24/08/2019.
//  Copyright © 2019 David Lenský. All rights reserved.
//

import RxSwift

extension AnyObserver {

    public typealias NextHandler = (Element) -> Void

    //===----------------------------------------------------------------------===//
    // MARK: - empty
    //===----------------------------------------------------------------------===//

    public static var empty: AnyObserver<Element> { .init { _ in } }

    //===----------------------------------------------------------------------===//
    // MARK: - static
    //===----------------------------------------------------------------------===//

    public func `static`<Result>(_ value: Element) -> AnyObserver<Result> {
        self.mapObserver({ _ in value })
    }

    //===----------------------------------------------------------------------===//
    // MARK: - onNext
    //===----------------------------------------------------------------------===//

    public static func onNext(_ nextHandler: @escaping NextHandler) -> AnyObserver {
        .init(eventHandler: { event in
            if case let .next(element) = event {
                nextHandler(element)
            }
        })
    }

    public static func onNext<Result, Model: AnyObject>(_ vm: Model, _ action: @escaping (Model, Result) -> Void) -> AnyObserver<Result> {
        AnyObserver<Result>.onNext { [weak vm] element in
            if vm != nil { action(vm!, element) }
        }
    }

    public static func onNext<Model: AnyObject>(_ vm: Model, _ action: @escaping (Model) -> Void) -> AnyObserver<Void> {
        AnyObserver<Void>.onNext { [weak vm] event in
            if vm != nil { action(vm!) }
        }
    }

    //===----------------------------------------------------------------------===//
    // MARK: - filter
    //===----------------------------------------------------------------------===//

    public func filter(_ predicate: @escaping (Element) -> Bool) -> AnyObserver<Element> {
        AnyObserver<Element> { event in
            // Is next event and should be filtered out (failed predicate)
            if case let .next(element) = event, !predicate(element) { return }
            self.on(event)
        }
    }

    public func filter<Model: AnyObject>(_ vm: Model, _ predicate: @escaping (Model, Element) -> Bool) -> AnyObserver<Element> {
        AnyObserver<Element> { [weak vm] event in
            if vm != nil {
                // Is next event and should be filtered out (failed predicate)
                if case let .next(element) = event, !predicate(vm!, element) { return }
                self.on(event)
            }
        }
    }

    //===----------------------------------------------------------------------===//
    // MARK: - map
    //===----------------------------------------------------------------------===//

    public func map<Result>(_ transform: @escaping (Result) throws -> Element) -> AnyObserver<Result> {
        self.mapObserver(transform)
    }

    public func map<Result>(_ transformTo: Element) -> AnyObserver<Result> {
        self.mapObserver( { _ in transformTo } )
    }

    // TODO: - optional self in closures?
    public func map<Result, Model: AnyObject>(_ vm: Model, _ transform: @escaping (Model, Result) throws -> Element) -> AnyObserver<Result> {
        return AnyObserver<Result> { [weak vm] event in
            let closure = { [weak vm] (res: Result) -> Element in
                if vm == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
                return try transform(vm!, res)
            }

            self.on(event.map(closure))
        }
    }

    public func map<Model: AnyObject>(_ vm: Model, _ transform: @escaping (Model) throws -> Element) -> AnyObserver<Void> {
        return AnyObserver<Void> { [weak vm] event in
            let closure = { [weak vm] (_: Void) -> Element in
                if vm == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
                return try transform(vm!)
            }
            
            self.on(event.map(closure))
        }
    }

    //===----------------------------------------------------------------------===//
    // MARK: - compactMap
    //===----------------------------------------------------------------------===//

    public func compactMap<Result>(_ transform: @escaping (Result) throws -> Element?) -> AnyObserver<Result> {
        return AnyObserver<Result> { event in
            let transformedEvent = event.map(transform)
            if case let .next(optElement) = transformedEvent, optElement == nil { return }

            self.on(transformedEvent.map { $0! })
        }
    }

    public func compactMap<Result, Model: AnyObject>(_ vm: Model, _ transform: @escaping (Model, Result) throws -> Element?) -> AnyObserver<Result> {
        return AnyObserver<Result> { [weak vm] event in
            let closure = { [weak vm] (res: Result) -> Element? in
                if vm == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
                return try transform(vm!, res)
            }

            let transformedEvent = event.map(closure)
            if case let .next(optElement) = transformedEvent, optElement == nil { return }

            self.on(transformedEvent.map { $0! })
        }
    }

    public func compactMap(_ transform: @escaping () throws -> Element?) -> AnyObserver<Void> {
            return AnyObserver<Void> { event in
                let transformedEvent = event.map(transform)
                if case let .next(optElement) = transformedEvent, optElement == nil { return }

                self.on(transformedEvent.map { $0! })
            }
        }

    public func compactMap<Model: AnyObject>(_ vm: Model, _ transform: @escaping (Model) throws -> Element?) -> AnyObserver<Void> {
        return AnyObserver<Void> { [weak vm] event in
            let closure = { [weak vm] (_: Void) -> Element? in
                if vm == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
                return try transform(vm!)
            }

            let transformedEvent = event.map(closure)
            if case let .next(optElement) = transformedEvent, optElement == nil { return }

            self.on(transformedEvent.map { $0! })
        }
    }

    //===----------------------------------------------------------------------===//
    // MARK: - linkNext
    //===----------------------------------------------------------------------===//

    public func linkNext(to observer: AnyObserver<Element>) -> AnyObserver<Element> {
        return AnyObserver<Element> { event in
            if case let .next(element) = event {
                observer.onNext(element)
            }
            self.on(event)
        }
    }

    //===----------------------------------------------------------------------===//
    // MARK: - do
    //===----------------------------------------------------------------------===//

    public func `do`<Model: AnyObject>(_ vm: Model, _ task: @escaping (Model, Element) -> Void) -> AnyObserver<Element> {
        return AnyObserver<Element> { [weak vm] event in
            if vm == nil { return }
            if case let .next(element) = event { task(vm!, element) }
            self.on(event)
        }
    }

}

//===----------------------------------------------------------------------===//
// MARK: - observer
//===----------------------------------------------------------------------===//

public extension ObserverType {

    var observer: AnyObserver<Element> { self.asObserver() }

}
