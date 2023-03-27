//
//  File.swift
//  
//
//  Created by David Lenský on 25.03.2023.
//

import Foundation
import MapKit
import RxSwift

public extension Reactive where Base: MKMapView {

	var updateAnnotations: Binder<(add: [MKAnnotation], remove: [MKAnnotation])> {
		.init(base) { view, annotations in
			view.updateAnnotations(add: annotations.add, remove: annotations.remove)
		}
	}

}
