//
//  CGPoint+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 27/03/2018.
//

import UIKit

// -------------------------------------------------------------------------------
// MARK: - CGPoint
// -------------------------------------------------------------------------------

public extension CGPoint {

	static func + (left: CGPoint, right: CGPoint) -> CGPoint {
		return CGPoint(x: left.x + right.x, y: left.y + right.y)
	}

	static func - (left: CGPoint, right: CGPoint) -> CGPoint {
		return CGPoint(x: left.x - right.x, y: left.y - right.y)
	}

    static func += (left: inout CGPoint, right: CGPoint) {
        left.x += right.x
        left.y += right.y
    }

    static func -= (left: inout CGPoint, right: CGPoint) {
        left.x -= right.x
        left.y -= right.y
    }

}

// -------------------------------------------------------------------------------
// MARK: - CGSize
// -------------------------------------------------------------------------------

public extension CGPoint {

    static func + (left: CGPoint, right: CGSize) -> CGPoint {
        return CGPoint(x: left.x + right.width, y: left.y + right.height)
    }

    static func - (left: CGPoint, right: CGSize) -> CGPoint {
        return CGPoint(x: left.x - right.width, y: left.y - right.height)
    }

    static func += (left: inout CGPoint, right: CGSize) {
        left.x += right.w
        left.y += right.h
    }

    static func -= (left: inout CGPoint, right: CGSize) {
        left.x -= right.w
        left.y -= right.h
    }

    static func * (left: CGPoint, right: CGSize) -> CGPoint {
        return CGPoint(x: left.x * right.width, y: left.y * right.height)
    }

    static func / (left: CGPoint, right: CGSize) -> CGPoint {
        return CGPoint(x: left.x / right.width, y: left.y / right.height)
    }

}

// -------------------------------------------------------------------------------
// MARK: - Double
// -------------------------------------------------------------------------------

public extension CGPoint {

    static func + (left: CGPoint, right: Double) -> CGPoint {
        return CGPoint(x: Double(left.x) + right, y: Double(left.y) + right)
    }

    static func - (left: CGPoint, right: Double) -> CGPoint {
        return CGPoint(x: Double(left.x) - right, y: Double(left.y) - right)
    }

    static func * (left: CGPoint, right: Double) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
    }

    static func * (left: Double, right: CGPoint) -> CGPoint {
        return CGPoint(x: left * right.x, y: left * right.y)
    }

    static func / (left: CGPoint, right: Double) -> CGPoint {
        return CGPoint(x: left.x / right, y: left.y / right)
    }

}

// -------------------------------------------------------------------------------
// MARK: - CGFloat
// -------------------------------------------------------------------------------

public extension CGPoint {

    static func + (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x + right, y: left.y + right)
    }

    static func - (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x - right, y: left.y - right)
    }

    static func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
    }

    static func * (left: CGFloat, right: CGPoint) -> CGPoint {
        return CGPoint(x: left * right.x, y: left * right.y)
    }

}

public func abs(_ point: CGPoint) -> CGPoint {
    return CGPoint(x: abs(point.x), y: abs(point.y))
}
