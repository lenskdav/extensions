//
//  UIEdgeInsets+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 15/01/2020.
//  Copyright © 2020 David Lenský. All rights reserved.
//

import UIKit

public extension UIEdgeInsets {

    init(inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }

    init(t: CGFloat = 0.0, l: CGFloat = 0.0, b: CGFloat = 0.0, r: CGFloat = 0.0) {
        self.init(top: t, left: l, bottom: b, right: r)
    }

    init(horizontal: CGFloat) {
        self.init(l: horizontal, r: horizontal)
    }

    init(h: CGFloat) {
        self.init(horizontal: h)
    }

    init(vertical: CGFloat) {
        self.init(t: vertical, b: vertical)
    }

    init(v: CGFloat) {
        self.init(vertical: v)
    }

    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(t: vertical, l: horizontal, b: vertical, r: horizontal)
    }

    init(h: CGFloat, v: CGFloat) {
        self.init(horizontal: h, vertical: v)
    }

    var horizontal: CGFloat {
        left + right
    }

    var vertical: CGFloat {
        top + bottom
    }

    func updated(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> UIEdgeInsets {
        .init(top: top ?? self.top,
              left: left ?? self.left,
              bottom: bottom ?? self.bottom,
              right: right ?? self.right)
    }

}
