//
//  NewsResponse.swift
//  UHive
//
//  Created by Lin Thit on 5/3/25.
//

import Foundation

struct NewsResponse: Decodable {
    let data: [News]
    let count: Int
}

struct News: Decodable {
    let id: String
    let content: String
    let description: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content, description, createdAt, updatedAt
    }
}
