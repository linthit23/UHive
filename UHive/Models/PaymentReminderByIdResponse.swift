//
//  PaymentReminderByIdResponse.swift
//  UHive
//
//  Created by Lin Thit on 5/2/25.
//

import Foundation

struct PaymentReminderByIdResponse: Decodable {
    let id: String
    let dueDate: String
    let amount: Float
    let createdAt: String
    let updatedAt: String
    let users: [PaymentReminderUser]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case dueDate, amount, createdAt, updatedAt, users
    }
}

struct PaymentReminderUser: Decodable {
    let id: String
    let user: ProfileResponse
    let paymentReminder: String
    let status: String
    let invoice: String?
    let slip: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user, paymentReminder, status, invoice, slip
    }
}
