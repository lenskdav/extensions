//
//  UIStackView.swift
//  Extensions
//
//  Created by David Lenský on 07.04.2021.
//  Copyright © 2021 David Lenský. All rights reserved.
//

import UIKit

public extension UIStackView {

    @discardableResult
    func axis(_ axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        return self
    }

    @discardableResult
    func alignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }

    @discardableResult
    func distribution(_ distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }

    @discardableResult
    func spacing(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }

    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }

}

public extension Array where Element: UIView {

    func add(to stackView: UIStackView) {
        self.forEach { stackView.addArrangedSubview($0) }
    }

}
