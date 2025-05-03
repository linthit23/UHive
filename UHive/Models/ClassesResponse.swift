//
//  ClassesResponse.swift
//  UHive
//
//  Created by Lin Thit on 5/4/25.
//

import Foundation

struct ClassesResponse: Decodable {
    let data: [Class]
    let count: Int
}

struct Class: Decodable {
    let id: String
    let start: String
    let end: String
    let subject: String
    let room: String
    let instructor: String
    let status: String
    let createdAt: String
    let updatedAt: String
    let user: ProfileResponse
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case start, end, subject, room, instructor, status, createdAt, updatedAt, user
    }
}
