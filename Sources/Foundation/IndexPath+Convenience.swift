//
//  IndexPath+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 14/09/2019.
//  Copyright © 2019 David Lenský. All rights reserved.
//

import Foundation

extension IndexPath {

    public static var zero: IndexPath { IndexPath(i: 0, s: 0) }

    public init(i: Int, s: Int) {
        self.init(item: i, section: s)
    }

}
