//
//  CharacterSet+Convenience.swift
//  
//
//  Created by Jakub Lares on 18.01.2022.
//

import Foundation

extension CharacterSet {

    public enum Predefined {

        case usernameCharSet
        case characterCharSet
        case campaignCharSet
        case rewardCodeCharSet
        case none

        public var charSet: CharacterSet {
            switch self {
            case .usernameCharSet:
                return CharacterSet(charactersIn: "qwertzuiopasdfghjklyxcvbnmQWERTZUIOPASDFGHJKLYXCVBNM._1234567890").inverted
            case .characterCharSet:
                return CharacterSet(charactersIn: "qwertzuiopasdfghjklyxcvbnm QWERTZUIOPASDFGHJKLYXCVBNM").inverted
            case .campaignCharSet:
                return .init(charactersIn: "")
            case .rewardCodeCharSet:
                return CharacterSet(charactersIn: "qwertzuiopasdfghjklyxcvbnmQWERTZUIOPASDFGHJKLYXCVBNM1234567890").inverted
            case .none:
                return .init(charactersIn: "")
            }
        }

        public var charLimit: Int {
            switch self {
            case .usernameCharSet, .characterCharSet:
                return 32
            case .campaignCharSet:
                return 64
            case .rewardCodeCharSet:
                return 10
            case .none:
                return 64
            }
        }
    }

}
