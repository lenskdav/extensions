//
//  UIView+Constraints.swift
//  
//
//  Created by Jakub Lares on 08.11.2021.
//

import UIKit

extension UIView {

    public func alignWith(_ view: UIView?, inset: UIEdgeInsets = UIEdgeInsets(t: 0, l: 0, b: 0, r: 0)) {
        guard let view = view else { return }

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: inset.left),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -inset.right),
            topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset.bottom)
        ])
    }

    public func setConstraints(height: CGFloat? = nil, width: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
