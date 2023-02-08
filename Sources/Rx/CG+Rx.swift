//
//  CG+Rx.swift
//  Extensions
//
//  Created by David Lenský on 24/08/2019.
//  Copyright © 2019 David Lenský. All rights reserved.
//

import RxSwift
import UIKit

public extension ObservableType where Element == CGPoint {

    var x: Observable<CGFloat> { return self.map { $0.x } }
    var y: Observable<CGFloat> { return self.map { $0.y } }

}
