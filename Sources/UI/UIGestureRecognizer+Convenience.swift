//
//  UIGestureRecognizer+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 29/09/2019.
//  Copyright © 2019 David Lenský. All rights reserved.
//

import UIKit

public extension UIGestureRecognizer.State {

    var name: String {
        switch self {
        case .began: return "began"
        case .cancelled: return "cancelled"
        case .changed: return "changed"
        case .ended: return "ended"
        case .failed: return "failed"
        case .possible: return "possible"
        @unknown default: return "unknown"
        }
    }

}
