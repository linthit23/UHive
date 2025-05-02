//
//  PaymentSubmissionResponse.swift
//  UHive
//
//  Created by Lin Thit on 5/3/25.
//

import Foundation

struct PaymentSubmissionResponse: Decodable {
    let id: String
    let user: String
    let paymentReminder: String
    let status: String
    let invoice: String
    let slip: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user, paymentReminder, status, invoice, slip
    }
}

