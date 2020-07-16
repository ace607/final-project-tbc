//
//  APIService.swift
//  news
//
//  Created by Admin on 7/4/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class APIService {
    
    public static let service = APIService()
    
    typealias CompletionBlock<T: Codable> = (Result<T, Error>) -> ()
    
    func get<T: Codable>(url: String, needsHeader: Bool, completion: @escaping CompletionBlock<T>) {
        guard let url = URL(string: url) else {return}
        
        var urlRequest = URLRequest(url: url)
        if needsHeader {
            urlRequest.setValue(Constants.apiKey, forHTTPHeaderField: "X-Api-Key")
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, res, err) in
            
            if let err = err {
                completion(.failure(err))
            }
            
            do {
                guard let data = data else {return}
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(T.self, from: data)
                
                completion(.success(decoded))
            } catch let err {
                completion(.failure(err))
            }
            
        }.resume()
    }
}
