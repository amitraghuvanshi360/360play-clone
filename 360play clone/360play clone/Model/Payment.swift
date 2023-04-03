//
//  Model.swift
//  360play clone
//
//  Created by Ankush Sharma on 29/03/23.
//

import Foundation


// MARK: - Payment
struct Payment: Codable {
    let status: Int
    let statusMessage: String
    let statusMessageArabic: JSONNull?
    let data: [Datum]

    enum CodingKeys: String, CodingKey {
        case status
        case statusMessage = "status_message"
        case statusMessageArabic = "status_message_arabic"
        case data
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let name: String
    let active: Bool
    let created, updated: String
    let ipaddress: JSONNull?
}


// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
