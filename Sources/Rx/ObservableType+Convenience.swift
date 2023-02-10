//
//  ObservableType+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 24/08/2019.
//  Copyright © 2019 David Lenský. All rights reserved.
//

import Foundation
import RxSwift

/*✻**********************************************************************/
// MARK: - Base
/*✻**********************************************************************/

public extension ObservableType {

    var void: Observable<Void> { map { _ in } }

    func `static`<T: Any>(_ param: T) -> Observable<T> {
        map { _ in param }
    }

    func or<Result>(_ alternative: Result) -> Observable<Result> where Element == Result? {
        map { $0 ?? alternative }
    }

    func wrapOptional<T>() -> Observable<T?> where Element == T {
        map { element -> T? in element }
    }

}

/*✻**********************************************************************/
// MARK: - linkNext
/*✻**********************************************************************/

public extension ObservableType {

    func linkNext<O: ObserverType>(to observer: O) -> Observable<Element> where O.Element == Element {
        `do`(onNext: { element in observer.onNext(element) })
    }

    func linkNext<O: ObserverType>(to observerArray: [O]) -> Observable<Element> where O.Element == Element {
        `do`(onNext: { element in observerArray.forEach { $0.onNext(element) } })
    }

    func linkNext<O: ObserverType>(to observers: O...) -> Observable<Element> where O.Element == Element {
        linkNext(to: observers)
    }

    func linkMapNext<O: ObserverType>(to observer: O, transform: @escaping (Element) -> O.Element) -> Observable<Element> {
        `do`(onNext: { element in
            let newElement = transform(element)
            observer.onNext(newElement)
        })
    }

    func linkMapNext<O: ObserverType>(to observer: O, _ keypath: KeyPath<Element, O.Element>) -> Observable<Element> {
        `do`(onNext: { element in
            let newElement = element[keyPath: keypath]
            observer.onNext(newElement)
        })
    }

    func linkMapNext<Input, Output, O: ObserverType>(to observer: O, _ keypath: KeyPath<Input, Output>) -> Observable<Element> where Element == Input?, O.Element == Output? {
        `do`(onNext: { element in
            let newElement = element?[keyPath: keypath]
            observer.onNext(newElement)
        })
    }

    func linkMapNext<Input, Output, O: ObserverType>(to observer: O, _ keypath: KeyPath<Input, Output?>) -> Observable<Element> where Element == Input?, O.Element == Output? {
        `do`(onNext: { element in
            let newElement = element?[keyPath: keypath]
            observer.onNext(newElement)
        })
    }

    func linkMapError<O: ObserverType>(to observer: O, transform: @escaping (Error) -> O.Element) -> Observable<Element> {
        `do`(onError: { error in
            let newElement = transform(error)
            observer.onNext(newElement)
        })
    }

    func linkMapError<O: ObserverType>(to observer: O, _ keypath: KeyPath<Error, O.Element>) -> Observable<Element> {
        `do`(onError: { error in
            let newElement = error[keyPath: keypath]
            observer.onNext(newElement)
        })
    }
    
    func linkMapError<Output, O: ObserverType>(to observer: O, _ keypath: KeyPath<Error, Output>) -> Observable<Element> where O.Element == Output? {
        `do`(onError: { error in
            let newElement = error[keyPath: keypath]
            observer.onNext(newElement)
        })
    }

}

/*✻**********************************************************************/
// MARK: - bind
/*✻**********************************************************************/

public extension ObservableType {

    func bind<Observer: ObserverType>(to observerArray: [Observer]) -> RxSwift.Disposable where Self.Element == Observer.Element {
        subscribe { event in
            observerArray.forEach { $0.on(event) }
        }
    }

    func bindMap<O: ObserverType>(to observer: O, transform: @escaping (Element) -> O.Element) -> Disposable {
        map(transform).bind(to: observer)
    }

    func bindMap<O: ObserverType>(to observers: O..., transform: @escaping (Element) -> O.Element) -> Disposable {
        map(transform).bind(to: observers)
    }

    func bindMap<O: ObserverType>(to observer: O, _ keyPath: KeyPath<Element, O.Element>) -> Disposable {
        map({ $0[keyPath: keyPath] }).bind(to: observer)
    }

    func bindMap<O: ObserverType>(to observers: O..., keyPath: KeyPath<Element, O.Element>) -> Disposable {
        map({ $0[keyPath: keyPath] }).bind(to: observers)
    }

}

/*✻**********************************************************************/
// MARK: - send
/*✻**********************************************************************/

public extension ObservableType {

    func sendOnNext<O: ObserverType>(_ param: O.Element, to observer: O) -> Observable<Element> {
        `do`(onNext: { _ in observer.onNext(param) })
    }

    func sendOnNext<O: ObserverType>(to observer: O) -> Observable<Element> where O.Element == Void {
        `do`(onNext: { _ in observer.onNext(()) })
    }

    func sendOnError<O: ObserverType>(_ param: O.Element, to observer: O) -> Observable<Element> {
        `do`(onError: { _ in observer.onNext(param) })
    }

    func sendOnError<O: ObserverType>(to observer: O) -> Observable<Element> where O.Element == Void {
        `do`(onError: { _ in observer.onNext(()) })
    }

}

/*✻**********************************************************************/
// MARK: - complete
/*✻**********************************************************************/

public extension ObservableType {

    func completeOnNext<O: ObserverType>(_ observer: O) -> Observable<Element> {
        `do`(onNext: { _ in observer.onCompleted() })
    }

}

/*✻**********************************************************************/
// MARK: - dispose
/*✻**********************************************************************/

public extension ObservableType {

    func disposeOnNext(_ closure: @escaping () -> Disposable?) -> Observable<Element> {
        `do`(onNext: { _ in closure()?.dispose() })
    }

    func disposeOnNext<Model: AnyObject>(_ model: Model, _ keypath: KeyPath<Model, Disposable?>) -> Observable<Element> {
        `do`(onNext: { [weak model] _ in
            model?[keyPath: keypath]?.dispose()
        })
    }

}

/*✻**********************************************************************/
// MARK: - do
/*✻**********************************************************************/

public extension ObservableType {

    func `do`<Model: AnyObject>(_ model: Model, _ predicate: @escaping (Model, Element) throws -> Void) -> Observable<Element> {
        `do` { [weak model] element in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
            try predicate(model!, element)
        }
    }

    func doOnNil<Result, Model: AnyObject>(_ model: Model, _ predicate: @escaping (Model) throws -> Void) -> Observable<Result?> where Element == Result? {
        `do` { [weak model] element in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }

            guard element == nil else { return }
            try predicate(model!)
        }
    }

    func doOnError<Model: AnyObject>(_ model: Model, _ predicate: @escaping (Model, Error) throws -> Void) -> Observable<Element> {
        `do`(onError: { [weak model] error in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
            try predicate(model!, error)
        })
    }

}

/*✻**********************************************************************/
// MARK: - filter
/*✻**********************************************************************/

public extension ObservableType {

    func filter(_ value: Element) -> Observable<Element> where Element: Equatable {
        filter { element in element == value }
    }

    func filterOut(_ value: Element) -> Observable<Element> where Element: Equatable {
        filter { element in element != value }
    }

    func filter<Value: Equatable>(_ keyPath: KeyPath<Element, Value>, _ value: Value) -> Observable<Element> {
        filter { element in element[keyPath: keyPath] == value }
    }

    func filterOut<Value: Equatable>(_ keyPath: KeyPath<Element, Value>, _ value: Value) -> Observable<Element> {
        filter { element in element[keyPath: keyPath] != value }
    }

    func filter<Model: AnyObject>(_ model: Model, _ predicate: @escaping (Model, Element) throws -> Bool) -> Observable<Element> {
        filter { [weak model] element -> Bool in
            if model == nil { return false }
            return try predicate(model!, element)
        }
    }

}

/*✻**********************************************************************/
// MARK: - arrayFilter
/*✻**********************************************************************/

public extension ObservableType {

    func arrayFilter<Input>(_ transform: @escaping (Input) -> Bool) -> Observable<[Input]> where Element == [Input] {
        map { $0.filter { transform($0) } }
    }

    func arrayFilter<Input, Model: AnyObject>(_ model: Model,_ transform: @escaping (Model, Input) -> Bool) -> Observable<[Input]> where Element == [Input] {
        map { [weak model] element -> [Input] in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
            return element.filter { transform(model!, $0) }
        }
    }

}

/*✻**********************************************************************/
// MARK: - map & compactMap
/*✻**********************************************************************/

public extension ObservableType {

    func map<Result, Model: AnyObject>(_ model: Model, _ predicate: @escaping (Model, Element) throws -> Result) -> Observable<Result> {
        map { [weak model] element -> Result in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
            return try predicate(model!, element)
        }
    }

    func map<Result>(_ keyPath: KeyPath<Element, Result>) -> Observable<Result> {
        map { $0[keyPath: keyPath] }
    }

    func map<Input, Result>(_ keyPath: KeyPath<Input, Result>) -> Observable<Result?> where Element == Input? {
        map { $0?[keyPath: keyPath] }
    }

    func map<Input, Result>(_ keyPath: KeyPath<Input, Result?>) -> Observable<Result?> where Element == Input? {
        map { $0?[keyPath: keyPath] }
    }

    func compactMap<Result, Model: AnyObject>(_ model: Model, _ predicate: @escaping (Model, Element) throws -> Result?) -> Observable<Result> {
        compactMap { [weak model] element -> Result? in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
            return try predicate(model!, element)
        }
    }

    func compactMap<Result, Model: AnyObject>(_ model: Model, _ predicate: @escaping (Model) throws -> Result?) -> Observable<Result> {
        compactMap { [weak model] element -> Result? in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
            return try predicate(model!)
        }
    }

    func compactMap<Input, Result>(_ keyPath: KeyPath<Input, Result>) -> Observable<Result> where Element == Input? {
        compactMap { $0?[keyPath: keyPath] }
    }

    func compactMap<Input, Result>(_ keyPath: KeyPath<Input, Result?>) -> Observable<Result> where Element == Input? {
        compactMap { $0?[keyPath: keyPath] }
    }

}

/*✻**********************************************************************/
// MARK: - arrayMap & compactArrayMap
/*✻**********************************************************************/

public extension ObservableType {

    func arrayMap<Input, Result>(_ transform: @escaping (Input) -> Result) -> Observable<[Result]> where Element == [Input] {
        map { $0.map { transform($0) } }
    }

    func arrayMap<Input, Model: AnyObject, Result>(_ model: Model,_ transform: @escaping (Model, Input) -> Result) -> Observable<[Result]> where Element == [Input] {
        map { [weak model] element -> [Result] in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
            return element.map { transform(model!, $0) }
        }
    }

    func arrayMap<Input, Result>(_ keyPath: KeyPath<Input, Result>) -> Observable<[Result]> where Element == [Input] {
        map { $0.map { $0[keyPath: keyPath] } }
    }

    func arrayCompactMap<Input, Result>(_ transform: @escaping (Input) -> Result?) -> Observable<[Result]> where Element == [Input] {
        map { $0.compactMap { transform($0) } }
    }

    func arrayCompactMap<Input, Model: AnyObject, Result>(_ model: Model,_ transform: @escaping (Model, Input) -> Result?) -> Observable<[Result]> where Element == [Input] {
        map { [weak model] element -> [Result] in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
            return element.compactMap { transform(model!, $0) }
        }
    }

    func arrayCompactMap<Input, Result>(_ keyPath: KeyPath<Input, Result?>) -> Observable<[Result]> where Element == [Input] {
        map { $0.compactMap { $0[keyPath: keyPath] } }
    }

}

/*✻**********************************************************************/
// MARK: - flatMap
/*✻**********************************************************************/

public extension ObservableType {

    func flatMapLatest<Result, Model: AnyObject>(_ model: Model, _ closure: @escaping (Model, Element) throws -> Observable<Result>) -> Observable<Result> {
        flatMapLatest { [weak model] element -> Observable<Result> in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }

            return try closure(model!, element)
        }
    }

}

/*✻**********************************************************************/
// MARK: - Void versions
/*✻**********************************************************************/

public extension ObservableType where Element == Void {

    func `do`<Model: AnyObject>(_ model: Model, _ predicate: @escaping (Model) throws -> Void) -> Observable<Void> {
        `do` { [weak model] element in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
            try predicate(model!)
        }
    }

    func filter<Model: AnyObject>(_ model: Model, _ predicate: @escaping (Model) throws -> Bool) -> Observable<Element> {
        filter { [weak model] element -> Bool in
            if model == nil { return false }
            return try predicate(model!)
        }
    }

    func filter<Value: Equatable, Model: AnyObject>(_ model: Model, _ keyPath: KeyPath<Model, Value>, _ value: Value) -> Observable<Element> {
        filter { [weak model] element -> Bool in
            if model == nil { return false }
            return model![keyPath: keyPath] == value
        }
    }

    func filter<Value: Equatable, Model: AnyObject>(_ model: Model, _ keyPath: KeyPath<Model, Value?>, _ value: Value) -> Observable<Element> {
        filter { [weak model] element -> Bool in
            if model == nil { return false }
            return model![keyPath: keyPath] == value
        }
    }

    func filter<Value: Equatable, Model: AnyObject>(_ model: Model, _ keyPath: KeyPath<Model, Value>, _ value: Value?) -> Observable<Element> {
        filter { [weak model] element -> Bool in
            if model == nil { return false }
            return model![keyPath: keyPath] == value
        }
    }

    func map<Result, Model: AnyObject>(_ model: Model, _ predicate: @escaping (Model) throws -> Result) -> Observable<Result> {
        map { [weak model] _ -> Result in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
            return try predicate(model!)
        }
    }

    func map<Result, Model: AnyObject>(_ model: Model, _ keyPath: KeyPath<Model, Result>) -> Observable<Result> {
        map { [weak model] _ -> Result in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
            return model![keyPath: keyPath]
        }
    }

    func compactMap<Result, Model: AnyObject>(_ model: Model, _ keyPath: KeyPath<Model, Result?>) -> Observable<Result> {
        compactMap { [weak model] _ -> Result? in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }
            return model![keyPath: keyPath]
        }
    }

    func flatMapLatest<Result, Model: AnyObject>(_ model: Model, _ closure: @escaping (Model) throws -> Observable<Result>) -> Observable<Result> {
        flatMapLatest { [weak model] _ -> Observable<Result> in
            if model == nil { throw RxSwiftExtensionError.deinitializedClosureModel(type: String(describing: Model.self)) }

            return try closure(model!)
        }
    }

    func bindMap<O: ObserverType>(to observer: O, transform: @escaping () -> O.Element) -> Disposable {
        map(transform).bind(to: observer)
    }

    func bindMap<O: ObserverType>(to observers: O..., transform: @escaping () -> O.Element) -> Disposable {
        map(transform).bind(to: observers)
    }

}

public enum RxSwiftExtensionError: Error {
    case deinitializedClosureModel(type: String)
}
