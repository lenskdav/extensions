//
//  Rx+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 24/08/2019.
//  Copyright © 2019 David Lenský. All rights reserved.
//

import Foundation
import RxSwift

/**
 Protocol for extending types that might need to be converted to observables.
 */
public protocol ObservableProtocol { }
public extension ObservableProtocol {

    var observable: Observable<Self> { return Observable.from(optional: self) }
    var observableOptional: Observable<Self?> { return Observable.from(optional: self) }

}

public extension NSObjectProtocol {

    var observable: Observable<Self> { return Observable.from(optional: self) }
    var observableOptional: Observable<Self?> { return Observable.from(optional: self) }

}

public extension StringProtocol {

    var observable: Observable<Self> { return Observable.from(optional: self) }
    var observableOptional: Observable<Self?> { return Observable.from(optional: self) }

}

public extension Numeric {

    var observable: Observable<Self> { return Observable.from(optional: self) }
    var observableOptional: Observable<Self?> { return Observable.from(optional: self) }

}

public extension Error {

    func observable<T>() -> Observable<T> {
        Observable<T>.error(self)
    }

}

public extension ObservableType {
    var observable: Observable<Element> { self.asObservable() }
}

extension Bool: ObservableProtocol {}
extension Array: ObservableProtocol {}
