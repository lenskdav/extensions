//
//  CACornerMask+Convenience.swift
//  Kitea Database
//
//  Created by David Lenský on 26.04.2024.
//  Copyright © 2024 David Lenský. All rights reserved.

import UIKit

public extension CACornerMask {

    static var topLeft: Self { .layerMinXMinYCorner }
    static var topRight: Self { .layerMaxXMinYCorner }
    static var bottomLeft: Self { .layerMinXMaxYCorner }
    static var bottomRight: Self { .layerMaxXMaxYCorner }

    static var top: Self { [.topLeft, .topRight] }
    static var bottom: Self { [.bottomLeft, .bottomRight] }
    static var left: Self { [.topLeft, .bottomLeft] }
    static var right: Self { [.topRight, .bottomRight] }

    static var all: Self { [.topLeft, .topRight, .bottomLeft, .bottomRight] }
    static var none: Self { [] }

}
