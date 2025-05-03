//
//  AlertsService.swift
//  UHive
//
//  Created by Lin Thit on 5/3/25.
//

import Foundation
import Alamofire

class AlertsService {
    
    func fetchAllTests(
        completion: @escaping(TestsResponse?) -> Void
    ) {
        let request = APIManager.testsRequest()
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            headers: request.headers
        ) { (result: Result<TestsResponse, AFError>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print("Failed to fetch tests: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
