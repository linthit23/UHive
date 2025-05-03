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
    
    enum Endpoint {
        case login
        case profile
        case paymentReminder
        case paymentReminderById(String)
        case submitPayment(String)
        case news
        case newsById(String)
        case facilities
        case bookings
        case bookFacility(String)
        case tests
        case classes
        case posts
        
        var path: String {
            switch self {
            case .login:
                return "/auth/login"
            case .profile:
                return "/users/profile"
            case .paymentReminder:
                return "/payment-reminders"
            case .paymentReminderById(let id):
                return "/payment-reminders/\(id)"
            case .submitPayment(let id):
                return "/payment-reminders/\(id)/pay"
            case .news:
                return "/alerts"
            case .newsById(let id):
                return "/alerts/\(id)"
            case .facilities:
                return "/facilities"
            case .bookings:
                return "/facilities/bookings"
            case .bookFacility(let id):
                return "/facilities/\(id)/book"
            case .tests:
                return "/homeworks"
            case .classes:
                return "/classes?limit=100"
            case .posts:
                return "/posts?limit=100"
            }
        }
    }

    
    static func makeURL(for endpoint: Endpoint) -> String {
        return baseURL + endpoint.path
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
    
    static func profileRequest() -> (url: String, method: HTTPMethod, headers: HTTPHeaders) {
        let url = makeURL(for: .profile)
        let headers = AuthManager.shared.authHeaders()
        return (url, .get, headers)
    }
    
    static func paymentReminderRequest() -> (url: String, method: HTTPMethod, headers: HTTPHeaders) {
        let url = makeURL(for: .paymentReminder)
        let headers = AuthManager.shared.authHeaders()
        return (url, .get, headers)
    }
    
    static func paymentReminderByIdRequest(id: String) -> (url: String, method: HTTPMethod, headers: HTTPHeaders) {
        let url = makeURL(for: .paymentReminderById(id))
        let headers = AuthManager.shared.authHeaders()
        return (url, .get, headers)
    }
    
    static func submitPayment(id: String) -> (url: String, method: HTTPMethod, parameters: Parameters, headers: HTTPHeaders) {
        let url = makeURL(for: .submitPayment(id))
        let invoice = "INV-\(Int(Date().timeIntervalSince1970))"
        let slip = "http://localhost:3000/images/\(UUID().uuidString).png"
        let parameters: Parameters = [
            "invoice": invoice,
            "slip": slip
        ]
        let headers = AuthManager.shared.authHeaders()
        return (url, .post, parameters, headers)
    }
    
    static func newsRequest() -> (url: String, method: HTTPMethod, headers: HTTPHeaders) {
        let url = makeURL(for: .news)
        let headers = AuthManager.shared.authHeaders()
        return (url, .get, headers)
    }
    
    static func newsByIdRequest(id: String) -> (url: String, method: HTTPMethod, headers: HTTPHeaders) {
        let url = makeURL(for: .newsById(id))
        let headers = AuthManager.shared.authHeaders()
        return (url, .get, headers)
    }
    
    static func facilitiesRequest() -> (url: String, method: HTTPMethod, headers: HTTPHeaders) {
        let url = makeURL(for: .facilities)
        let headers = AuthManager.shared.authHeaders()
        return (url, .get, headers)
    }
    
    static func bookingsRequest() -> (url: String, method: HTTPMethod, headers: HTTPHeaders) {
        let url = makeURL(for: .bookings)
        let headers = AuthManager.shared.authHeaders()
        return (url, .get, headers)
    }
    
    static func bookFacility(
        id: String,
        date: String,
        start: String,
        end: String,
        numberOfPeople: Int,
        reason: String
    ) -> (url: String, method: HTTPMethod, parameters: Parameters, headers: HTTPHeaders) {
        let url = makeURL(for: .bookFacility(id))
        let parameters: Parameters = [
            "date": date,
            "start": start,
            "end": end,
            "number_of_people": numberOfPeople,
            "reason": reason
        ]
        let headers = AuthManager.shared.authHeaders()
        return (url, .post, parameters, headers)
    }
    
    static func testsRequest() -> (url: String, method: HTTPMethod, headers: HTTPHeaders) {
        let url = makeURL(for: .tests)
        let headers = AuthManager.shared.authHeaders()
        return (url, .get, headers)
    }
    
    static func classesRequest() -> (url: String, method: HTTPMethod, headers: HTTPHeaders) {
        let url = makeURL(for: .classes)
        let headers = AuthManager.shared.authHeaders()
        return (url, .get, headers)
    }
    
    static func postsRequest() -> (url: String, method: HTTPMethod, headers: HTTPHeaders) {
        let url = makeURL(for: .posts)
        let headers = AuthManager.shared.authHeaders()
        return (url, .get, headers)
    }
}
