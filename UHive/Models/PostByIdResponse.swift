//
//  PostByIdResponse.swift
//  UHive
//
//  Created by Lin Thit on 5/4/25.
//

import Foundation

struct PostByIdResponse: Decodable {
    let id: String
    let content: String
    let user: String
    let likes: [PostByIdLike]
    let comments: [PostByIdComment]
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content, user, likes, comments, createdAt, updatedAt
    }
}

struct PostByIdLike: Decodable {
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

struct PostByIdComment: Decodable {
    let content: String
    let user: ProfileResponse
    let id: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content, user, createdAt, updatedAt
    }
}
