//
//  ClassesService.swift
//  UHive
//
//  Created by Lin Thit on 5/4/25.
//

import Foundation
import Alamofire

class ClassesService {
    
    func fetchAllClasses(
        completion: @escaping(ClassesResponse?) -> Void
    ) {
        let request = APIManager.classesRequest()
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            headers: request.headers
        ) { (result: Result<ClassesResponse, AFError>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print("Failed to fetch classes: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
