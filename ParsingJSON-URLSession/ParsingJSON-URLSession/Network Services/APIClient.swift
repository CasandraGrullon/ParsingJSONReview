//
//  APIClient.swift
//  ParsingJSON-URLSession
//
//  Created by casandra grullon on 8/4/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

enum AppError: Error {
    case badURL(String)
    case networkError(Error)
    case decodingError(Error)
}

class APIClient {
    //Asynchronous calls:
    //Use a closure/callback
    //other tools you can use are delegation, NotificationCenter or Combine (new to iOS 13 +)
    func fetchData(completion: @escaping (Result <[Station], AppError>) -> () ) {
        let endpoint = "https://gbfs.citibikenyc.com/gbfs/en/station_information.json"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        //only need request when adding additional information
        //types of url requests:
        // .httpMethod = GET
        // .addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
            } else if let data = data {
                do {
                    let results = try JSONDecoder().decode(DataWrapper.self, from: data)
                    completion(.success(results.data.stations))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        dataTask.resume()
    }
}
