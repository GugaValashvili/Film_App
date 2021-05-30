//
//  NetworkManager.swift
//  Film App
//
//  Created by Guga Valashvili on 5/30/21.
//  Copyright © 2021 Guga Valashvili. All rights reserved.
//

//

import Foundation

class NetworkManager {
    let basePath: String
    
    static let shared = NetworkManager(basePath: API.baseURL)
    
    private init(basePath: String){
        self.basePath = basePath
    }

    private var apiKey: String {
        "&api_key=\(TheMovieDBApiKey.key)"
    }
    
    func getRequest<T: Decodable>(_ type: T.Type, path: String, complition: @escaping (Result<T, Error>) -> Void) {
        let url = URL(string: basePath + path + apiKey)!

        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: URLRequest(url: url), completionHandler: { (data, response, error) -> Void in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let entity = try decoder.decode(type, from: data)
                    DispatchQueue.main.async {
                        complition(.success(entity))
                    }
                } catch {
                    DispatchQueue.main.async {
                        complition(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    complition(.failure(error ?? APIError.networkFail))
                }
            }
        })
        task.resume()
    }
}
