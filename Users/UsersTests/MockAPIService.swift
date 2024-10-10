//
//  MockAPIService.swift
//  UsersTests
//
//  Created by Argh on 10/9/24.
//

import Foundation
@testable import Users

/// A mock implementation of `APIServiceProtocol` for testing purposes.
final class MockAPIService: APIServiceProtocol {
    /// A boolean flag indicating whether the mock service should return an error.
    var shouldReturnError = false
    
    /// A dictionary to store mock data generators for various model types.
    private var mockDataGenerators: [String: () -> Any] = [:]
    
    /// Initializes the `MockAPIService` and sets up mock data generators for different models.
    init() {
        // Generator for an array of UserModel
        mockDataGenerators[String(describing: [UserModel].self)] = {
            let mockUser = UserModel(
                id: 1,
                name: "John Doe",
                username: "johndoe",
                email: "johndoe@example.com",
                address: Address(street: "123 Main St", suite: "A", city: "Somewhere", zipCode: "12345"),
                phone: "555-555-5555",
                website: "example.com",
                company: Company(name: "Company", catchPhrase: "Catchphrase")
            )
            return [mockUser]
        }
        
        // Generator for an array of PostModel
        mockDataGenerators[String(describing: [PostModel].self)] = {
            let mockPost = PostModel(
                id: 1,
                title: "Title",
                description: "This is a sample post description."
            )
            return [mockPost]
        }
    }
    
    /// Fetches mock data for the specified API endpoint.
    /// - Parameters:
    ///   - endPoint: The endpoint to fetch data from (not used in mock).
    ///   - model: The type of model to decode the response into.
    ///   - params: Optional parameters to include in the request (not used in mock).
    ///   - completion: A closure that is called with the result of the mock API request,
    ///                 containing either the decoded data or an error.
    func getData<T: Decodable>(endPoint: EndPoints, model: T.Type, params: [String: Any]?, completion: @escaping (Result<T, CustomError>) -> Void) {
        DispatchQueue.main.async {
            // Simulate an error if the flag is set
            if self.shouldReturnError {
                completion(.failure(.invalidResponse))
                return
            }
            
            // Generate mock data for the requested model type
            if let mockDataGenerator = self.mockDataGenerators[String(describing: model)] {
                let mockData = mockDataGenerator()
                completion(.success(mockData as! T)) // Return the generated mock data
            } else {
                completion(.failure(.invalidData)) // Return error if model type is not found
            }
        }
    }
}
