//
//  APIManager.swift
//  UHive
//
//  Created by Lin Thit on 5/2/25.
//

import Foundation
import Alamofire

enum APIManager {
    
    static let baseURL = "http://192.168.1.134:3000"
    
    enum Endpoint: String {
        case login = "/auth/login"
    }
    
    static func makeURL(for endpoint: Endpoint) -> String {
        return baseURL + endpoint.rawValue
    }
    
    static func loginRequest(
        email: String,
        password: String
    ) -> (url: String, method: HTTPMethod, parameters: Parameters, headers: HTTPHeaders) {
        let url = makeURL(for: .login)
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        return (url, .post, parameters, headers)
    }
}
