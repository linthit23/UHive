//
//  ProfileResponse.swift
//  UHive
//
//  Created by Lin Thit on 5/2/25.
//

import Foundation

struct ProfileResponse: Decodable {
    let id: String
    let name: String
    let email: String
    let password: String
    let type: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case email
        case password
        case type
        case createdAt
        case updatedAt
    }
}
