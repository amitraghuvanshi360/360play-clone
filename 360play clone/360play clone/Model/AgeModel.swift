//
//  AgeModel.swift
//  360play clone
//
//  Created by Ankush Sharma on 30/03/23.
//

import Foundation

struct Group: Codable {
    let status: Int
    let statusMessage: String
    let statusMessageArabic: JSONNulls?
    let data: [ageGroup]

    enum CodingKeys: String, CodingKey {
        case status
        case statusMessage = "status_message"
        case statusMessageArabic = "status_message_arabic"
        case data
    }
}

// MARK: - Datum
struct ageGroup: Codable {
    let id: Int
    let name: String
    let active: Bool
    let created, updated: String
    let ipaddress: JSONNulls?
}

// MARK: - Encode/decode helpers

class JSONNulls: Codable, Hashable {

    public static func == (lhs: JSONNulls, rhs: JSONNulls) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNulls.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNulls"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
