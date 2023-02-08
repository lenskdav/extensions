//
//  String+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 24/01/2018.
//

import UIKit

public extension String {

    static func random(ofLength length: Int) -> String {
        let base = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        var randomString = ""
        length.times {
            let randomValue = Int(arc4random_uniform(UInt32(base.count)))
            randomString += String(base[randomValue])
        }
        return randomString
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont, attributes: [NSAttributedString.Key: Any]? = nil) -> CGFloat {

        let bbAttributes = attributes ?? [NSAttributedString.Key.font: font]

		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: bbAttributes, context: nil)

		return ceil(boundingBox.height)
	}

    func width(withConstrainedHeight height: CGFloat, font: UIFont, attributes: [NSAttributedString.Key: Any]? = nil) -> CGFloat {

        let bbAttributes = attributes ?? [NSAttributedString.Key.font: font]

        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: bbAttributes, context: nil)

        return ceil(boundingBox.width)
    }

    var escapedUrl: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }

    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func with(_ character: Character, at index: Int) -> String {
        var mutableStr = self

        let strIndex = mutableStr.index(mutableStr.startIndex, offsetBy: index)
        mutableStr.insert(character, at: strIndex)
        return mutableStr
    }

    var stripedOfWhitespaces: String {
        self.replacingOccurrences(of: " ", with: "")
    }

    mutating func trim() {
        self = self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isEmail: Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }

    var isHourMinuteTime: Bool {
        let regEx = "[0-9]{2,2}+:[0-9]{2,2}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }

    func attributed(lineSpacing: CGFloat? = nil) -> NSMutableAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]

        if let ls = lineSpacing {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = ls
            attributes[.paragraphStyle] = paragraphStyle
        }

        return NSMutableAttributedString(string: self, attributes: attributes)
    }

    var firstCapitalized: String {
        prefix(1).capitalized + dropFirst()
    }

}

public extension String {

    var emptyToNil: String? {
        isEmpty ? nil : self
    }

    var int: Int? {
        Int(self)
    }

    var double: Double? {
        Double(self)
    }

    var optional: String? {
        self
    }

}

public extension Optional where Wrapped == String {

    var emptyToNil: String? {
        switch self {
        case .some(let str): return str.isEmpty ? nil : str
        case .none: return nil
        }
    }

    func or(_ string: String) -> String {
        switch self {
        case .some(let str): return str
        case .none: return string
        }
    }

    var orEmpty: String {
        switch self {
        case .some(let str): return str
        case .none: return ""
        }
    }

    var nilOrEmpty: Bool {
        self == nil || self!.isEmpty
    }

}

public extension NSAttributedString {

    static var empty: NSAttributedString {
        NSAttributedString(string: "")
    }

    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.width)
    }

}

public extension Optional where  Wrapped == NSAttributedString {

    var orEmpty: NSAttributedString {
        or(.empty)
    }

}

public extension Substring {

    var string: String { String(self) }

}

public extension Array where Element == Substring {

    var strings: [String] {
        self.map { String($0) }
    }

}
