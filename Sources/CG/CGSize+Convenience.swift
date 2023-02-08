//
//  CGSize+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 19/12/2017.
//

import UIKit

// MARK: - Init

public extension CGSize {

    init(w: CGFloat, h: CGFloat) {
        self.init(width: w, height: h)
    }

    init(size: CGFloat) {
        self.init(width: size, height: size)
    }

    init(s: CGFloat) {
        self.init(size: s)
    }

    var w: CGFloat {
        return width
    }

    var h: CGFloat {
        return height
    }

    var point: CGPoint {
        CGPoint(x: w, y: h)
    }

}

// MARK: - CGSize

public extension CGSize {

	static func + (left: CGSize, right: CGSize) -> CGSize {
		return CGSize(width: left.width + right.width, height: left.height + right.height)
	}

	static func - (left: CGSize, right: CGSize) -> CGSize {
		return CGSize(width: left.width - right.width, height: left.height - right.height)
	}

    static func * (left: CGSize, right: CGSize) -> CGSize {
        return CGSize(width: left.w * right.w, height: left.h * right.h)
    }

    static func / (left: CGSize, right: CGSize) -> CGSize {
        return CGSize(width: left.w / right.w, height: left.h / right.h)
    }

}

// MARK: - CGFloat

public extension CGSize {

    static func + (left: CGSize, right: CGFloat) -> CGSize {
        return CGSize(width: left.width + right, height: left.height + right)
    }

    static func - (left: CGSize, right: CGFloat) -> CGSize {
        return CGSize(width: left.width - right, height: left.height - right)
    }

    static func * (left: CGSize, right: CGFloat) -> CGSize {
        return CGSize(width: left.width * right, height: left.height * right)
    }

    static func / (left: CGSize, right: CGFloat) -> CGSize {
        return CGSize(width: left.width / right, height: left.height / right)
    }

}

// MARK: - Double

public extension CGSize {

    static func + (left: CGSize, right: Double) -> CGSize {
        return CGSize(width: left.width + right, height: left.height + right)
    }

    static func - (left: CGSize, right: Double) -> CGSize {
        return CGSize(width: left.width - right, height: left.height - right)
    }

    static func / (left: CGSize, right: Double) -> CGSize {
        return CGSize(width: left.width / right, height: left.height / right)
    }

}
