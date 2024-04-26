//
//  Optional+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 18.05.2021.
//  Copyright © 2021 David Lenský. All rights reserved.
//

import Foundation

public extension Optional {

    func or(_ element: Wrapped) -> Wrapped {
        switch self {
        case .some(let wrapped):    wrapped
        case .none:                 element
        }
    }

    var isNil: Bool {
        switch self {
        case .some: false
        case .none: true
        }
    }

    var isNotNil: Bool {
        isNil.not
    }

}
