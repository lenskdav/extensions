//
//  NSCollectionLayout+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 10.05.2021.
//  Copyright © 2021 David Lenský. All rights reserved.
//

import UIKit

// -------------------------------------------------------------------------------
// MARK: - NSCollectionLayoutSize
// -------------------------------------------------------------------------------

public extension NSCollectionLayoutSize {

    convenience init(w: NSCollectionLayoutDimension, h: NSCollectionLayoutDimension) {
        self.init(widthDimension: w, heightDimension: h)
    }

}
