//
//  BookingsService.swift
//  UHive
//
//  Created by Lin Thit on 5/3/25.
//
import Foundation
import Alamofire

class BookingsService {
    
    func fetchAllFacilities(
        completion: @escaping(FacilitiesResponse?) -> Void
    ) {
        let request = APIManager.facilitiesRequest()
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            headers: request.headers
        ) {  (result: Result<FacilitiesResponse, AFError>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print("Failed to fetch facilities: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func fetchAllBookings(
        completion: @escaping(FacilityBookingsResponse?) -> Void
    ) {
        let request = APIManager.bookingsRequest()
        
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            headers: request.headers
        ) { (result: Result<FacilityBookingsResponse, AFError>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print("Failed to fetch bookings: \(error.localizedDescription)")
                completion(nil)
            }
            
        }
    }
    
    func bookFacility(id: String, date: String, start: String, end: String, numberOfPeople: Int, reason: String, completion: @escaping (BookedFacilityResponse?) -> Void) {
        let request = APIManager.bookFacility(id: id, date: date, start: start, end: end, numberOfPeople: numberOfPeople, reason: reason)
        print(request.parameters)
        NetworkManager.shared.request(
            request.url,
            method: request.method,
            parameters: request.parameters,
            encoding: JSONEncoding.default,
            headers: request.headers
        ) { (result: Result<BookedFacilityResponse, AFError>) in
            switch result {
            case .success(let response):
                completion(response)
                case .failure(let error):
                print("Failed to book facility: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
