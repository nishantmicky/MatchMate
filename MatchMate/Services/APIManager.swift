//
//  APIManager.swift
//  MatchMate
//
//  Created by Nishant Kumar on 01/03/25.
//

import Foundation

enum APiError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
}

class APIManager {
    
    static let shared = APIManager()
        
    private init() {}
    
    func fetchUserData(completion: @escaping (Result<[User], APiError>)->Void) {
        let url = URL(string: Constants.kApiUrl)
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil {
                completion(.failure(.invalidResponse))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(UserResults.self, from: data)
                    completion(.success(response.results!))
                    return
                } catch {
                    
                    completion(.failure(.decodingFailed))
                    return
                }
            } else {
                completion(.failure(.invalidResponse))
                return
            }
        }
        task.resume()
    }
}
