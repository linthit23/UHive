//
//  PaymentReminderResponse.swift
//  UHive
//
//  Created by Lin Thit on 5/2/25.
//

import Foundation

struct PaymentReminderResponse: Decodable {
    let data: [PaymentReminder]
    let count: Int
}

struct PaymentReminder: Decodable {
    let id: String
    let dueDate: String
    let amount: Float
    let createdAt: String
    let updatedAt: String
    let status: String
    let user: ProfileResponse
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case dueDate
        case amount
        case createdAt
        case updatedAt
        case status
        case user
    }
}
