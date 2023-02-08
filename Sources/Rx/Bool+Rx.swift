//
//  Bool+Rx.swift
//  Extensions
//
//  Created by David Lenský on 24/08/2019.
//  Copyright © 2019 David Lenský. All rights reserved.
//

import Foundation
import RxSwift

public extension ObservableType where Element == Bool {

    var inverted: Observable<Bool> {
        map { !$0 }
    }

    var not: Observable<Bool> {
        inverted
    }

    var ifTrue: Observable<Void> {
        filter { $0 }.void
    }

}

extension BehaviorSubject where Element == Bool {

    public func toggle() {
        guard let value = try? self.value() else { return }
        self.onNext(!value)
    }

}
