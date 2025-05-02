//
//  PaymentSubmissionRequest.swift
//  UHive
//
//  Created by Lin Thit on 5/3/25.
//

import Foundation

struct PaymentSubmissionRequest: Encodable {
    let invoice: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case invoice
        case image
    }
}
