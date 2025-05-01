//
//  AuthManager.swift
//  UHive
//
//  Created by Lin Thit on 5/2/25.
//

import Foundation
import Alamofire

class AuthManager {
    
    static let shared = AuthManager()
    private let tokenKey = "auth_token"
    
    var token: String? {
        get { UserDefaults.standard.string(forKey: tokenKey)}
        set {
            if let token = newValue {
                UserDefaults.standard.set(token, forKey: tokenKey)
            } else {
                UserDefaults.standard.removeObject(forKey: tokenKey)
            }
        }
    }
    
    func logout() {
        token = nil
    }
    
    func authHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = ["Content-Type":"application/json"]
        if let token = token {
            headers.add(name: "Authorization", value: "Bearer \(token)")
        }
        return headers
    }
}
