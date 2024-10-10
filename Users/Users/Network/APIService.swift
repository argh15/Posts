//
//  APIService.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import Foundation

/// A protocol that defines the methods for making API requests.
protocol APIServiceProtocol {
    
    /// Fetches data from the specified API endpoint.
    /// - Parameters:
    ///   - endPoint: The endpoint to fetch data from.
    ///   - model: The type of model to decode the response into.
    ///   - params: Optional parameters to include in the request.
    ///   - completion: A closure that is called with the result of the API request, containing either the decoded data or an error.
    func getData<T: Decodable>(
        endPoint: EndPoints,
        model: T.Type,
        params: [String: Any]?,
        completion: @escaping (Result<T, CustomError>) -> ()
    )
}

/// A concrete implementation of `APIServiceProtocol` that handles API requests.
struct APIService: APIServiceProtocol {
    
    /// Fetches data from the specified API endpoint.
    /// - Parameters:
    ///   - endPoint: The endpoint to fetch data from.
    ///   - model: The type of model to decode the response into.
    ///   - params: Optional parameters to include in the request.
    ///   - completion: A closure that is called with the result of the API request, containing either the decoded data or an error.
    func getData<T: Decodable>(
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
                        
            do {
                let decodedData = try JSONDecoder().decode(model, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        .resume()
    }
    
    /// Creates a URL with the specified base URL, endpoint, and optional parameters.
    /// - Parameters:
    ///   - baseURL: The base URL of the API.
    ///   - endPoint: The specific endpoint to append to the base URL.
    ///   - params: Optional parameters to include in the URL as query items.
    /// - Returns: A constructed URL if successful, otherwise `nil`.
    private func createURL(baseURL: String, endPoint: String, params: [String: Any]?) -> URL? {
        let urlString = baseURL + endPoint
        
        if let params = params {
            var urlComponents = URLComponents(string: urlString)
            urlComponents?.queryItems = params.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
            return urlComponents?.url // Return URL with query items if parameters exist
        }
        
        return URL(string: urlString) // Return the URL without parameters
    }
}
