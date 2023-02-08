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

}

/*✻**********************************************************************/
// MARK: - Equatable
/*✻**********************************************************************/

extension CLLocationCoordinate2D: Equatable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }

}
