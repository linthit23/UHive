//
//  BookedFacilityResponse.swift
//  UHive
//
//  Created by Lin Thit on 5/3/25.
//

import Foundation

struct BookedFacilityResponse: Codable {
    let user: String
    let facility: String
    let start: String
    let end: String
    let numberOfPeople: Int
    let reason: String
    let status: String
    let id: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case numberOfPeople = "number_of_people"
        case user, facility, start, end, reason, status, createdAt, updatedAt
    }
}
