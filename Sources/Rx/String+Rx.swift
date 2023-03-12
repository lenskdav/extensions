//
//  String+Rx.swift
//  Extensions
//
//  Created by David Lenský on 24/08/2019.
//  Copyright © 2019 David Lenský. All rights reserved.
//

import Foundation
import RxSwift

public extension Observable where Element == String {

    var isEmpty: Observable<Bool> {
        map { $0.isEmpty }
    }

    var isNotEmpty: Observable<Bool> {
        map { $0.isEmpty }.not
    }

    var isValidEmail: Observable<Bool> {
        map { $0.isEmail }
    }

    var trimmed: Observable<String> {
        map { $0.trimmed }
    }

    var stripedOfWhiteSpaces: Observable<String> {
        map { $0.stripedOfWhitespaces }
    }

    var uppercased: Observable<String> {
        map { $0.uppercased() }
    }

    var filterEmpty: Observable<String> {
        filter { !$0.isEmpty }
    }

	var emptyToNil: Observable<String?> {
		map { $0.emptyToNil }
	}

}

public extension Observable where Element == String? {

    var orEmpty: Observable<String> {
        map { $0.orEmpty }
    }

	var emptyToNil: Observable<String?> {
		map { $0?.emptyToNil }
	}

}
