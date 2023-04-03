//
//  ListGameModel.swift
//  360play clone
//
//  Created by Ankush Sharma on 30/03/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let game = try? JSONDecoder().decode(Game.self, from: jsonData)

import Foundation

// MARK: - Game
struct Game: Codable {
    let status: Int
    let statusMessage: String
    let statusMessageArabic: JSONAny?
    let data: [gameType]

    enum CodingKeys: String, CodingKey {
        case status
        case statusMessage = "status_message"
        case statusMessageArabic = "status_message_arabic"
        case data
    }
}

// MARK: - Datum
struct gameType: Codable {
    let id: Int
    let name, ageLimit: String
    let termsConditions, termsAndConditions: JSONAny?
    let active: Bool
    let created, updated, ipaddress: String

    enum CodingKeys: String, CodingKey {
        case id, name, ageLimit
        case termsConditions = "TermsConditions"
        case termsAndConditions, active, created, updated, ipaddress
    }
}

// MARK: - Encode/decode helpers

class JSONAny: Codable, Hashable {

    public static func == (lhs: JSONAny, rhs: JSONAny) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONAny.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONAny"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
