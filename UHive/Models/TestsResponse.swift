//
//  AlertsResponse.swift
//  UHive
//
//  Created by Lin Thit on 5/3/25.
//

import Foundation

struct TestsResponse: Decodable {
    let data: [Test]
    let count: Int
}

struct Test: Decodable {
    let id: String
    let dueDate: String
    let content: String
    let createdAt: String
    let updatedAt: String
    let user: ProfileResponse
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case dueDate, content, createdAt, updatedAt, user
    }
}
