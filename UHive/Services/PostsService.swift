//
//  PostsService.swift
//  UHive
//
//  Created by Lin Thit on 5/4/25.
//

import Foundation
import Alamofire

class PostsService {
    
    func fetchAllPosts(
        completion: @escaping(PostsResponse?) -> Void
    ) {
        let request = APIManager.postsRequest()
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            headers: request.headers
        ) { (result: Result<PostsResponse, AFError>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print("Failed to fetch posts: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
