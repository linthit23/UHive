//
//  LoginResponse.swift
//  UHive
//
//  Created by Lin Thit on 5/2/25.
//

import Foundation

struct LoginResponse: Decodable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "accessToken"
    }
}
