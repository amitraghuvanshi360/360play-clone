//
//  GameSlotModel.swift
//  360play clone
//
//  Created by Ankush Sharma on 06/04/23.
//

import Foundation

// MARK: - GameSlot
struct GameSlot: Codable {
    let status: Int
    let statusMessage: String
    let statusMessageArabic: JSONNull?
    let data: [GameType]

    enum CodingKeys: String, CodingKey {
        case status
        case statusMessage = "status_message"
        case statusMessageArabic = "status_message_arabic"
        case data
    }
}

// MARK: - Datum
struct GameType: Codable {
    let id, serviceMasterID: Int
    let name, description: String
    let personCount, kids, adults, amount: Int
    let active: Bool
    let duration: Int
    let created, updated, ipaddress: String

    enum CodingKeys: String, CodingKey {
        case id
        case serviceMasterID = "serviceMasterId"
        case name, description, personCount, kids, adults, amount, active, duration, created, updated, ipaddress
    }
}

// MARK: - Encode/decode helpers

class JSONNullss: Codable, Hashable {

    public static func == (lhs: JSONNullss, rhs: JSONNullss) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNullss.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
