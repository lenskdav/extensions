//
//  UIButton+Rx.swift
//  Extensions
//
//  Created by David Lenský on 10.05.2024.
//  Copyright © 2024 David Lenský. All rights reserved.

import RxCocoa
import RxSwift
import UIKit

public extension Reactive where Base: UIButton {

    var throttleTap: Observable<Void> {
        tap.throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
    }

}
