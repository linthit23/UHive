//
//  LoginService.swift
//  UHive
//
//  Created by Lin Thit on 5/2/25.
//

import Foundation
import Alamofire

class LoginService {
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        let request = APIManager.loginRequest(email: email, password: password)
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            parameters: request.parameters,
            encoding: JSONEncoding.default,
            headers: request.headers
        ) { (result: Result<LoginResponse, AFError>) in
            switch result {
            case .success(let response):
                AuthManager.shared.token = response.token
                completion(true)
            case .failure(let error):
                print("Login failed: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}
