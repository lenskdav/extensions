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

}

/*✻**********************************************************************/
// MARK: - MapPoint
/*✻**********************************************************************/

public extension CLLocationCoordinate2D {

    var point: MKMapPoint {
        .init(self)
    }

}

/*✻**********************************************************************/
// MARK: - String
/*✻**********************************************************************/

public extension CLLocationCoordinate2D {

    init?(string: String) {
        let components = string.components(separatedBy: ",").map(\.trimmed)
        guard components.count == 2 else { return nil }

        guard let lastV = components.first?.last else { return nil }
        guard let lastH = components.last?.last else { return nil }

        var latitude: Double?
        var longitude: Double?

        switch lastV {
        case "N": latitude = components.first?.dropLast(1).string.double
        case "S":
            latitude = components.first?.dropLast(1).string.double
            latitude?.negate()
        default: return nil
        }

        switch lastH {
        case "E": longitude = components.last?.dropLast(1).string.double
        case "W":
            longitude = components.last?.dropLast(1).string.double
            longitude?.negate()
        default: return nil
        }

        guard let latitude, let longitude else { return nil }
        self.init(latitude: latitude, longitude: longitude)
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

	var jsString: String {
		let lat = latitude.string(format: "%.7f")
		let lon = longitude.string(format: "%.7f")

		return "\(lon), \(lat)"
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
