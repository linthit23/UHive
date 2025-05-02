//
//  NewsService.swift
//  UHive
//
//  Created by Lin Thit on 5/3/25.
//
import Foundation
import Alamofire

class NewsService {
    
    func fetchAllNews(
        completion: @escaping(NewsResponse?) -> Void
    ) {
        let request = APIManager.newsRequest()
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            headers: request.headers
        ) {  (result: Result<NewsResponse, AFError>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print("Failed to fetch news: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func fetchNewsById(
        id: String,
        completion: @escaping (NewsDetailResponse?) -> Void
    ) {
        let request = APIManager.newsByIdRequest(id: id)
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            headers: request.headers
        ) { (result: Result<NewsDetailResponse, AFError>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print("Failed to fetch news detail \(error.localizedDescription)")
                completion(nil)
            }
            
        }
    }
}
