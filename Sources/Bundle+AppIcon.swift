//
//  Bundle+AppIcon.swift
//  Extensions
//
//  Created by Jozef Matus on 20/11/2018.
//

import UIKit

extension Bundle {

    public var icon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last {
            return UIImage(named: lastIcon)
        }
        return nil
    }

}
