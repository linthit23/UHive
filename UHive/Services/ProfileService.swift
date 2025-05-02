//
//  ProfileService.swift
//  UHive
//
//  Created by Lin Thit on 5/2/25.
//

import Foundation
import Alamofire

class ProfileService {
    
    func fetchProfile(completion: @escaping (ProfileResponse?) -> Void) {
        let request = APIManager.profileRequest()
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            headers: request.headers
        ) { (result: Result<ProfileResponse, AFError>) in
            switch result {
            case .success(let profile):
                completion(profile)
            case .failure(let error):
                print("Failed to fetch profile: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}

