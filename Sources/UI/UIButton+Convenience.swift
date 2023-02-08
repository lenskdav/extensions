//
//  UIButton.swift
//  Extensions
//
//  Created by David Lenský on 20/04/2018.
//

import UIKit

extension UIButton {

	public func setBackgroundColor(color: UIColor, forState: UIControl.State) {
		UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
		UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
		UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
		let colorImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		self.setBackgroundImage(colorImage, for: forState)
	}

}
