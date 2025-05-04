//
//  ProfileResponse.swift
//  UHive
//
//  Created by Lin Thit on 5/2/25.
//

import Foundation

struct ProfileResponse: Codable {
    let id: String
    let name: String
    let email: String
    let password: String
    let type: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case email
        case password
        case type
        case createdAt
        case updatedAt
    }
}

extension ProfileResponse {
    private static let cacheKey = "CachedProfile"
    
    func saveToCache() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: Self.cacheKey)
        }
    }
    
    static func loadFromCache() -> ProfileResponse? {
        if let savedData = UserDefaults.standard.data(forKey: Self.cacheKey),
           let profile = try? JSONDecoder().decode(ProfileResponse.self, from: savedData) {
            return profile
        }
        return nil
    }
    
    static func clearCache() {
        UserDefaults.standard.removeObject(forKey: Self.cacheKey)
    }
}
