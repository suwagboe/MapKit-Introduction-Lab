//
//  apiClient.swift
//  MapKit Introduction Lab
//
//  Created by Pursuit on 2/24/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import Foundation
import NetworkHelper


struct SchoolAPIClient {
    static func getSchoolLocations(completion: @escaping (Result<[SchoolData], AppError>) -> ()){
        let endpointURL = "https://data.cityofnewyork.us/resource/uq7m-95z8.json"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(.networkClientError(error)))
            case .success(let data):
                do{
                    let dataResult = try JSONDecoder().decode([SchoolData].self, from: data )
                    completion(.success(dataResult))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
            
    
}

}

}

/*
 static func getBookData(_ userCategory: String, completion: @escaping (Result<[BookData],AppError>) -> ()){
        let urlEndpoint = "https://api.nytimes.com/svc/books/v3/lists/current/\(userCategory).json?api-key=\(APIKeys.NYTimesBestSellersKey)"
        
        guard let url = URL(string: urlEndpoint) else {
            completion(.failure(.badURL(urlEndpoint)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { result in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let bookWrapper = try JSONDecoder().decode(TopLevelBookResult.self, from: data)
                    completion(.success(bookWrapper.results.books))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
*/
