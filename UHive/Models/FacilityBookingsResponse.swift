//
//  FacilityBookingsResponse.swift
//  UHive
//
//  Created by Lin Thit on 5/3/25.
//

import Foundation

struct FacilityBookingsResponse: Codable {
    let data: [FacilityBooking]
    let count: Int
}

struct FacilityBooking: Codable {
    let id: String
    let user: BookingUser
    let facility: Facility
    let start: String
    let end: String
    let numberOfPeople: Int
    let reason: String
    let status: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case numberOfPeople = "number_of_people"
        case user, facility, start, end, reason, status, createdAt, updatedAt
    }
}

struct BookingUser: Codable {
    
    let id: String
    let name: String
    let email: String
    let password: String
    let type: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, password, type, createdAt, updatedAt
    }
}
