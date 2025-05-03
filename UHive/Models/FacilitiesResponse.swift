//
//  FacilitiesResponse.swift
//  UHive
//
//  Created by Lin Thit on 5/3/25.
//

import Foundation

struct FacilitiesResponse: Codable {
    let data: [Facility]
    let count: Int
}

struct Facility: Codable {
    let id: String
    let name: String
    let availableHours: [AvailableHour]
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case availableHours = "available_hours"
        case createdAt
        case updatedAt
    }
}

struct AvailableHour: Codable {
    let id: String
    let start: String
    let end: String
    let user: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case start, end, user
    }
}
