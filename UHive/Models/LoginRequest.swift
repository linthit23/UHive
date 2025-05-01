//
//  LoginRequest.swift
//  UHive
//
//  Created by Lin Thit on 5/2/25.
//

import Foundation

struct LoginRequest: Encodable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email 
        case password
    }
}
