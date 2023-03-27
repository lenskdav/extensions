//
//  Map+Convenience.swift
//  
//
//  Created by David Lenský on 18.01.2023.
//

import Foundation
import MapKit

public extension MKMapPoint {

    var pointRect: MKMapRect {
        .init(origin: self,
              size: .init(s: 0.1))
    }

}

public extension MKMapSize {

    init(s: Double) {
        self.init(width: s, height: s)
    }

}

public extension MKMapView {

	func updateAnnotations(add: [MKAnnotation], remove: [MKAnnotation]) {
		print("Annotationsss: ", annotations)

		self.removeAnnotations(remove)
		self.addAnnotations(add)
	}

}
