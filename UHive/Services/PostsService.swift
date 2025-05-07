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
    
    func fetchPostById(
        id: String,
        completion: @escaping (PostByIdResponse?) -> Void
    ) {
        let request = APIManager.postsByIdRequest(id: id)
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            headers: request.headers
        ) { (result: Result<PostByIdResponse, AFError>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print("Failed to fetch post \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func commentOnPost(
        id: String,
        content: String,
        completion: @escaping (CommentPost?) -> Void
    ) {
        let request = APIManager.commentOnPostRequest(id: id, content: content)
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            parameters: request.parameters,
            encoding: JSONEncoding.default,
            headers: request.headers
        ) {  (result: Result<CommentPost, AFError>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print("Failed to fetch post \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func likeOnPost(
        id: String,
        completion: @escaping (LikePost?) -> Void
    ) {
        let request = APIManager.likeOnPostRequest(id: id)
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            headers: request.headers
        ) { (result: Result<LikePost, AFError>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print("Failed to fetch post \(error.localizedDescription)")
                completion(nil)
            }
            }
    }
    
    func unlikeOnPost(
        id: String,
        completion: @escaping (UnlikePost?) -> Void
    ) {
        let request = APIManager.unlikeOnPostRequest(id: id)
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            headers: request.headers
        ) { (result: Result<UnlikePost, AFError>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print("Failed to fetch post \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func posting(
        content: String,
        completion: @escaping (CommentPost?) -> Void
    ) {
        let request = APIManager.postingRequest(content: content)
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            parameters: request.parameters,
            encoding: JSONEncoding.default,
            headers: request.headers) { (result: Result<CommentPost, AFError>) in
                switch result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    print("Failed to fetch post: \(error.localizedDescription)")
                    completion(nil)
                }
            }
    }
}
