//
//  Codable.swift
//  
//
//  Created by David Lenský on 26.07.2024.
//

public struct OptionalDecodable<Base: Decodable>: Decodable {
    public let value: Base?

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
            self.value = nil
        }
    }
}
