//
//  PostsResponse.swift
//  UHive
//
//  Created by Lin Thit on 5/4/25.
//

import Foundation

struct PostsResponse: Decodable {
    let data: [Post]
    let count: Int
}

struct Post: Decodable {
    let id: String
    let content: String
    let user: ProfileResponse
    let likes: [String]
    let comments: [Comment]
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content, user, likes, comments, createdAt, updatedAt
    }
}

struct Comment: Decodable {
    let content: String
    let user: String
    let id: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content, user, createdAt, updatedAt
    }
}

struct CommentPost: Decodable {
    let id: String
    let content: String
    let user: String
    let likes: [String]
    let comments: [Comment]
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content, user, likes, comments, createdAt, updatedAt
    }
}

struct LikePost: Decodable {
    let id: String
    let content: String
    let user: String
    let likes: [String]
    let comments: [Comment]
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content, user, likes, comments, createdAt, updatedAt
    }
}

struct UnlikePost: Decodable {
    let id: String
    let content: String
    let user: String
    let likes: [String]
    let comments: [Comment]
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content, user, likes, comments, createdAt, updatedAt
    }
}
