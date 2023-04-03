//
//  UserAuthentication.swift
//  360play clone
//
//  Created by Ankush Sharma on 31/03/23.
//

import Foundation

// MARK: - UserAuthentication
struct UserAuthentication: Codable {
    let status: Int
    let statusMessage: String
    let statusMessageArabic: JsonAny?
    let data: [User]?

    enum CodingKeys: String, CodingKey {
        case status
        case statusMessage = "status_message"
        case statusMessageArabic = "status_message_arabic"
        case data
    }
}

// MARK: - User
struct User: Codable {
    let id, groupID, unitID: Int
    let name, email: String
    let countrycode: JsonAny?
    let mobile, gender: String
    let country: JsonAny?
    let dob: String
    let image, password, passwordhash, passwordsalt: JsonAny?
    let age: Int
    let nationality: JsonAny?
    let lastlogin: String
    let isverified, active: Bool
    let rolecode: Int
    let rolename: String
    let book, entry, exit: Bool
    let created, updated, ipaddress, roles: String

    enum CodingKeys: String, CodingKey {
        case id
        case groupID = "groupId"
        case unitID = "unitId"
        case name, email, countrycode, mobile, gender, country, dob, image, password, passwordhash, passwordsalt, age, nationality, lastlogin, isverified, active, rolecode, rolename, book, entry, exit, created, updated, ipaddress
        case roles = "Roles"
    }
}

// MARK: - Encode/decode helpers

class JsonAny: Codable, Hashable {

    public static func == (lhs: JsonAny, rhs: JsonAny) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JsonAny.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JsonAny"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
