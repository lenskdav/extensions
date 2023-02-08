//
//  File.swift
//  
//
//  Created by David Lenský on 10.12.2021.
//

import Foundation
import RxSwift

extension Binder where Value == Void {

    public init<Target: AnyObject>(_ target: Target, scheduler: ImmediateSchedulerType = MainScheduler(), binding: @escaping (Target) -> Void) {
        self.init(target) { target, _ in binding(target) }
    }

}
