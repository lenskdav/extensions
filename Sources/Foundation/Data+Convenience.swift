//
//  File.swift
//  
//
//  Created by David Lenský on 24.02.2023.
//

import Foundation

public extension Data {

	func string(with encoding: String.Encoding) -> String? {
		String(data: self, encoding: encoding)
	}

}
