//
//  UIImage+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 23/03/2018.
//

import UIKit

public extension UIImage {

	func resizedImage(width: CGFloat, height: CGFloat) -> UIImage? {
		let size = CGSize(width: width, height: height)
		UIGraphicsBeginImageContext(size)
		self.draw(in: CGRect(origin: CGPoint.zero, size: size))
		let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return resizedImage?.withRenderingMode(self.renderingMode)
	}

    func withSaturation(_ saturation: CGFloat) -> UIImage {
        guard let cgImage = self.cgImage else { return self }
        guard let filter = CIFilter(name: "CIColorControls") else { return self }
        filter.setValue(CIImage(cgImage: cgImage), forKey: kCIInputImageKey)
        filter.setValue(saturation, forKey: kCIInputSaturationKey)
        guard let result = filter.value(forKey: kCIOutputImageKey) as? CIImage else { return self }
        guard let newCgImage = CIContext(options: nil).createCGImage(result, from: result.extent) else { return self }
        return UIImage(cgImage: newCgImage, scale: UIScreen.main.scale, orientation: imageOrientation)
    }

    func rotated(by degrees: Int) -> UIImage? {
        let radians = CGFloat(degrees) * CGFloat.pi / 180.0

        let transformation = CGAffineTransform(rotationAngle: CGFloat(radians))
        let newRect = CGRect(origin: CGPoint.zero, size: size).applying(transformation)

        // Trim off the extremely small float value to prevent core graphics from rounding it up
        let newSize = CGSize(w: floor(newRect.width),
                             h: floor(newRect.height))

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.w / 2.0,
                            y: newSize.h / 2.0)

        // Rotate around middle
        context.rotate(by: CGFloat(radians))

        // Draw the image at its center
        self.draw(in: CGRect(x: -size.w / 2.0,
                             y: -size.h / 2.0,
                             w: size.w,
                             h: size.h))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

    func cropped(to: CGRect) -> UIImage? {

        func rad(_ degree: Double) -> CGFloat {
            return CGFloat(degree / 180.0 * .pi)
        }

        var rectTransform: CGAffineTransform
        switch imageOrientation {
        case .left:
            rectTransform = CGAffineTransform(rotationAngle: rad(90)).translatedBy(x: 0, y: -self.size.height)
        case .right:
            rectTransform = CGAffineTransform(rotationAngle: rad(-90)).translatedBy(x: -self.size.width, y: 0)
        case .down:
            rectTransform = CGAffineTransform(rotationAngle: rad(-180)).translatedBy(x: -self.size.width, y: -self.size.height)
        default:
            rectTransform = .identity
        }
        rectTransform = rectTransform.scaledBy(x: self.scale, y: self.scale)

        let origin = to.origin * self.scale
        let size = to.size * self.scale

        let rect = CGRect(origin: origin, size: size).applying(rectTransform)

        guard let newCgImage = self.cgImage?.cropping(to: rect) else { return nil }

        return UIImage(cgImage: newCgImage, scale: self.scale, orientation: self.imageOrientation)
    }

}

public extension String {

    var image: UIImage? {
        UIImage(named: self)
    }

}
