//
//  Numeric+Rx.swift
//  Extensions
//
//  Created by David Lenský on 24/08/2019.
//  Copyright © 2019 David Lenský. All rights reserved.
//

import RxSwift
import UIKit

public extension Observable where Element == Int {

    var string: Observable<String> {
        return self.map { $0.string }
    }

    var signedString: Observable<String> {
        return self.map { $0.signedString() }
    }

}

public extension BehaviorSubject where Element == Int {

     func increment(by number: Int = 1, withLimit limit: Int = Int.max) {
        guard let value = try? self.value() else { return }
        let newValue = min(value + number, limit)
        guard newValue != value else { return }
        self.onNext(newValue)
    }

    func decrement(by number: Int = 1, withLimit limit: Int = Int.min) {
        guard let value = try? self.value() else { return }
        let newValue = max(value - number, limit)
        guard newValue != value else { return }
        self.onNext(newValue)
    }

    func incObserver(limit: Int = .max) -> AnyObserver<Int> {
        observer
            .map(self) { vm, number in
                guard let value = try? vm.value() else { return .zero }
                return min(value + number, limit)
            }
    }

}

public extension BehaviorSubject where Element == CGFloat {

    func increment(by number: CGFloat, withLimit limit: CGFloat = CGFloat.greatestFiniteMagnitude) {
        guard let value = try? self.value() else { return }
        let newValue = min(value + number, limit)
        guard newValue != value else { return }
        self.onNext(newValue)
    }

    func incObserver(limit: CGFloat) -> AnyObserver<CGFloat> {
        observer
            .map(self) { vm, number in
                guard let value = try? vm.value() else { return .zero }
                return min(value + number, limit)
            }
    }

}
