//
//  Numeric+Cast.swift
//  Extensions
//
//  Created by David Lenský on 19/01/2018.
//

import UIKit

// MARK: - Addition

public extension CGFloat {

	static func + (left: CGFloat, right: Int) -> CGFloat {
		left + CGFloat(right)
	}

	static func + (left: Int, right: CGFloat) -> CGFloat {
		CGFloat(left) + right
	}

    static func + (left: CGFloat, right: Double) -> CGFloat {
        left + CGFloat(right)
    }

    static func + (left: Double, right: CGFloat) -> CGFloat {
        CGFloat(left) + right
    }

}

// MARK: - Subtraction

public extension CGFloat {

    static func - (left: CGFloat, right: Int) -> CGFloat {
        left - CGFloat(right)
    }

    static func - (left: Int, right: CGFloat) -> CGFloat {
        CGFloat(left) - right
    }

    static func - (left: CGFloat, right: Double) -> CGFloat {
        left - CGFloat(right)
    }

    static func - (left: Double, right: CGFloat) -> CGFloat {
        CGFloat(left) - right
    }

}

public extension Double {

    static func - (left: Double, right: Int) -> Double {
        left - Double(right)
    }

    static func - (left: Int, right: Double) -> Double {
        Double(left) - right
    }

}

// MARK: - Multiply

extension CGFloat {

	public static func * (left: CGFloat, right: Int) -> CGFloat {
		left * CGFloat(right)
	}

	public static func * (left: Int, right: CGFloat) -> CGFloat {
		CGFloat(left) * right
	}

    public static func * (left: CGFloat, right: Double) -> CGFloat {
        left * CGFloat(right)
    }

    public static func * (left: Double, right: CGFloat) -> CGFloat {
        CGFloat(left) * right
    }

}

// MARK: - Division

public extension CGFloat {

    static func / (left: CGFloat, right: Int) -> CGFloat {
        left / CGFloat(right)
    }

    static func / (left: Int, right: CGFloat) -> CGFloat {
        CGFloat(left) / right
    }

}

public extension Double {

    static func / (left: Double, right: CGFloat) -> CGFloat {
        CGFloat(left) / right
    }

    static func / (left: CGFloat, right: Double) -> CGFloat {
        left / CGFloat(right)
    }

    static func / (left: Double, right: Int) -> Double {
        left / Double(right)
    }

    static func / (left: Int, right: Double) -> Double {
        Double(left) / right
    }

}

// MARK: - Int Convenience

public extension Int {

    var ns: NSNumber {
        NSNumber(value: self)
    }

    var float: Float {
        Float(self)
    }

    var string: String {
        String(self)
    }

    var decimalString: String? {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf.string(from: ns)
    }

    func signedString(signedZero: Bool = true) -> String {
        switch self {
        case .min ..< 0: return "-" + abs.string
        case 0: return signedZero ? "±0" : "0"
        case 1 ... .max: return "+" + string
        default: return "never gonna happen"
        }
    }

    func times(_ foo: () -> Void) {
        for _ in 0..<self {
            foo()
        }
    }

    func times(_ foo: (Int) -> Void) {
        for i in 0..<self {
            foo(i)
        }
    }

    static func random(min: Int = Int.min, max: Int = Int.max) -> Int {
        var randomNum: UInt32 = 0
        repeat {
            randomNum = arc4random_uniform(UInt32(max + 1))
        } while randomNum < min
        return Int(randomNum)
    }

    var isOdd: Bool {
        (self % 2) == 1
    }

    var isEven: Bool {
        (self % 2) == 0
    }

    var isPositive: Bool {
        self > 0
    }

    var isNegative: Bool {
        self < 0
    }

    var int32: Int32 {
        Int32(self)
    }

    var abs: Int {
        Swift.abs(self)
    }

    var cg: CGFloat {
        CGFloat(self)
    }

    static func mod(_ x: Int, _ m: Int) -> Int {
        let r = x % m.abs
        return r < 0 ? r + m : r
    }

    func mod(_ m: Int) -> Int {
        let r = self % m.abs
        return r < 0 ? r + m : r
    }

    var zeroToNil: Int? {
        self == 0 ? nil : self
    }

}

// MARK: - Bool Convenience

public extension Bool {

    var int: Int {
        self ? 1 : 0
    }

    var cgFloat: CGFloat {
        self ? 1.0 : 0.0
    }

}

// MARK: - CGFloat Convenience

public extension CGFloat {

    var ns: NSNumber {
        .init(value: double)
    }

    var int: Int {
        Int(self)
    }

    var isInt: Bool {
        !(CGFloat(self.int) < abs(self))
    }

    var double: Double {
        Double(self)
    }

    var isPositive: Bool {
        self > 0.0
    }

    var isNegative: Bool {
        self < 0.0
    }

	/**
	 Common formats: %d , %.2f, %ld, %@
	 */
	func string(format: String) -> String {
		String(format: format, self)
	}

    var signum: Int {
        if self > 0.0 { return 1 }
        if self < 0.0 { return -1 }
        return 0
    }

    static func mod(_ x: CGFloat, _ m: CGFloat) -> CGFloat {
        let r = x.remainder(dividingBy: abs(m))
        return r < 0 ? r + m : r
    }

    func mod(_ m: CGFloat) -> CGFloat {
        let r = remainder(dividingBy: abs(m))
        return r < 0 ? r + m : r
    }

}

// MARK: - Double Convenience

public extension Double {

    var int: Int {
        Int(self)
    }

    var cg: CGFloat {
        CGFloat(self)
    }

    var ns: NSNumber {
        .init(floatLiteral: self)
    }

    var float: Float {
        Float(self)
    }

    var isInt: Bool {
        !(Double(self.int) < abs(self))
    }

    var isPositive: Bool {
        self > 0.0
    }

    var isNegative: Bool {
        self < 0.0
    }

    /**
     Common formats: %d , %.2f, %ld, %@
     */
    func string(format: String) -> String {
        String(format: format, self)
    }

     var signum: Int {
        if self > 0.0 { return 1 }
        if self < 0.0 { return -1 }
        return 0
    }

    static func mod(_ x: Double, _ m: Double) -> Double {
        let r = x.remainder(dividingBy: abs(m))
        return r < 0 ? r + m : r
    }

    func mod(_ m: Double) -> Double {
        let r = remainder(dividingBy: abs(m))
        return r < 0 ? r + m : r
    }

}

// MARK: - Float Convenience

public extension Float {

    var cg: CGFloat {
        CGFloat(self)
    }

    var double: Double {
        Double(self)
    }

    var int: Int {
        Int(self)
    }

}

// MARK: - Int32 Convenience

public extension Int32 {

    var int: Int { Int(self) }

}
