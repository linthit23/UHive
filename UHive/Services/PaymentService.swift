//
//  PaymentService.swift
//  UHive
//
//  Created by Lin Thit on 5/2/25.
//

import Foundation
import Alamofire
import UIKit

class PaymentService {
    
    func fetchAllPaymentReminders(
        completion: @escaping(PaymentReminderResponse?) -> Void
    ) {
        let request = APIManager.paymentReminderRequest()
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            headers: request.headers
        ) { (result: Result<PaymentReminderResponse, AFError>) in
            switch result {
            case .success(let paymentReminder):
                completion(paymentReminder)
            case .failure(let error):
                print("Failed to fetch payments: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func fetchPaymentReminderById(
        id: String,
        completion: @escaping (PaymentReminderByIdResponse?) -> Void
    ) {
        let request = APIManager.paymentReminderByIdRequest(id: id)
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            headers: request.headers
        ) { (result: Result<PaymentReminderByIdResponse, AFError>) in
            switch result {
            case .success(let reminder):
                completion(reminder)
            case .failure(let error):
                print("Failed to fetch payment reminder by ID: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func submitPaymentReminder(
        id: String,
        completion: @escaping (PaymentSubmissionResponse?) -> Void
    ) {
        let request = APIManager.submitPayment(id: id)
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            parameters: request.parameters,
            encoding: JSONEncoding.default,
            headers: request.headers
        ) { (result: Result<PaymentSubmissionResponse, AFError>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print("Failed to submit payment reminder \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
}
