//
//  UICollectionView+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 14.04.2021.
//  Copyright © 2021 David Lenský. All rights reserved.
//

import UIKit

public extension UICollectionView {

    func scrollToTop(animated: Bool = true) {
        guard isIndexPathValid(.zero) else { return }
        scrollToItem(at: .zero, at: .bottom, animated: animated)
    }

    func isIndexPathValid(_ indexPath: IndexPath) -> Bool {
        indexPath.section < numberOfSections && indexPath.row < numberOfItems(inSection: indexPath.section)
    }

}
