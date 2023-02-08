//
//  UILabel+Convenience.swift
//  Extensions
//
//  Created by David Lensky on 25/02/2019.
//  Copyright © 2019 David Lensky. All rights reserved.
//

import UIKit

public extension UILabel {

    func setTextWithSmallDecimalFraction(_ text: String) {
        guard let index = text.firstIndex(of: ".") else { return }

        let attrString = NSMutableAttributedString(string: text)
        let attrName = NSAttributedString.Key.font

        var range = NSRange(text.startIndex..<index, in: text)
        var attrValue = self.font ?? .systemFont(ofSize: 10.0)
        attrString.addAttribute(attrName, value: attrValue, range: range)

        range = NSRange(index..<text.endIndex, in: text)
        attrValue = self.font.withSize(self.font.pointSize / 2.0)
        attrString.addAttribute(attrName, value: attrValue, range: range)
        self.attributedText = attrString
    }

    func addKernAttr(_ kern: CGFloat) {
        let fontSize = self.font.pointSize

        let attrText: NSMutableAttributedString = {
            if self.attributedText != nil { return NSMutableAttributedString(attributedString: self.attributedText!) }
            return NSMutableAttributedString(string: self.text ?? "")
        }()

        attrText.addAttribute(NSAttributedString.Key.kern, value: fontSize * (kern / 1000.0), range: NSRange(location: 0, length: attrText.length - 1))
        self.attributedText = attrText
    }

}

public extension UILabel {

    func sizeToFit(width: CGFloat) {
        let newSize = sizeThatFits(.init(width: max(width, 200.0), height: .greatestFiniteMagnitude))
        frame.size = .init(width: max(width, newSize.width), height: newSize.height)
        preferredMaxLayoutWidth = width
    }

}
