//
//  Comparable+Convenience.swift
//  
//
//  Created by David Lenský on 27.06.2022.
//

import Foundation

public extension Comparable {

    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }

}
