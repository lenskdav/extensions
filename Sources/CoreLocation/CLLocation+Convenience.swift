//
//  File.swift
//  
//
//  Created by David Lenský on 08.01.2023.
//

import Foundation
import CoreLocation
import MapKit

/*✻**********************************************************************/
// MARK: - Location
/*✻**********************************************************************/

public extension CLLocationCoordinate2D {

    var location: CLLocation {
        .init(latitude: latitude, longitude: longitude)
    }

    var point: MKMapPoint {
        .init(self)
    }

    var string: String {
        switch (latitude.isPositive, longitude.isPositive) {
        case (true, true):
            return latitude.string(format: "%.7fN") + ", " + longitude.string(format: "%.7fE")
        case (true, false):
            return latitude.string(format: "%.7fN") + ", " + longitude.string(format: "%.7fW")
        case (false, true):
            return latitude.string(format: "%.7fS") + ", " + longitude.string(format: "%.7fE")
        case (false, false):
            return latitude.string(format: "%.7fS") + ", " + longitude.string(format: "%.7fW")
        }
    }

}

/*✻**********************************************************************/
// MARK: - Equatable
/*✻**********************************************************************/

extension CLLocationCoordinate2D: Equatable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }

}
