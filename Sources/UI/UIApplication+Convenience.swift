//
//  UIApplication+Convenience.swift
//  Extensions
//
//  Created by Jakub Majdl on 26.01.2022.
//

import UIKit

extension UIApplication {

    public var topViewController: UIViewController? {
        return getTopViewController(windows.filter { $0.isKeyWindow }.first?.rootViewController)
    }

    func getTopViewController(_ vc: UIViewController?) -> UIViewController? {
        if let presentedViewController = vc?.presentedViewController {
            return getTopViewController(presentedViewController)
        }
        if let navigationViewController = vc as? UINavigationController {
            return getTopViewController(navigationViewController.visibleViewController)
        }
        if let selectedViewController = (vc as? UITabBarController)?.selectedViewController {
            return getTopViewController(selectedViewController)
        }
        return vc
    }
}
