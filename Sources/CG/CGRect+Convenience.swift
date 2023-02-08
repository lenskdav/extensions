//
//  CGRect+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 03/09/2019.
//  Copyright © 2019 David Lenský. All rights reserved.
//

import UIKit

public extension CGRect {

    init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(x: x, y: y, width: w, height: h)
    }

    init(o: CGPoint, s: CGSize) {
        self.init(origin: o, size: s)
    }

    /* Can't use in SpriteKit, because Y axis is inverted */
    init(center: CGPoint, size: CGSize) {
        self.init(origin: CGPoint(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0), size: size)
    }

    /* Can't use in SpriteKit, because Y axis is inverted */
    init(c: CGPoint, s: CGSize) {
        self.init(center: c, size: s)
    }

    /* Can't use in SpriteKit, because Y axis is inverted */
    var center: CGPoint {
        get { return CGPoint(x: midX, y: midY) }
        set { origin = CGPoint(x: newValue.x - size.width / 2.0, y: newValue.y - size.height / 2.0) }
    }

    /* SpriteKit version of center */
    init(spriteCenter: CGPoint, size: CGSize) {
        self.init(origin: CGPoint(x: spriteCenter.x - size.width / 2.0, y: spriteCenter.y + size.height / 2.0), size: size)
    }

    init(sc: CGPoint, s: CGSize) {
        self.init(spriteCenter: sc, size: s)
    }

    var spriteCenter: CGPoint {
        get { CGPoint(x: origin.x + size.w / 2.0, y: origin.y - size.h / 2.0) }
        set { origin = CGPoint(x: newValue.x - size.width / 2.0, y: newValue.y + size.height / 2.0) }
    }

}
