//
//  APIService.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import Foundation

struct APIService {
    
    func getData<T: Codable>(
        endPoint: EndPoints,
        model: T.Type,
        params: [String: Any]? = nil,
        completion: @escaping (Result<T, CustomError>) ->()
    ) {
        
        guard let url = createURL(baseURL: APIConstants().baseURL, endPoint: endPoint.rawValue, params: params) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(model, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        .resume()
    }
    
    private func createURL(baseURL: String, endPoint: String, params: [String: Any]?) -> URL? {
        let urlString = baseURL + endPoint
        
        if let params = params {
            var urlComponents = URLComponents(string: urlString)
            urlComponents?.queryItems = params.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
            return urlComponents?.url
        }
        
        return URL(string: urlString)
    }
}
