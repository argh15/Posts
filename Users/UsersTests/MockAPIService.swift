//
//  MockAPIService.swift
//  UsersTests
//
//  Created by Argh on 10/9/24.
//

import Foundation
@testable import Users

final class MockAPIService: APIServiceProtocol {
    
    var shouldReturnError = false
    
    private var mockDataGenerators: [String: () -> Any] = [:]
    
    init() {
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
        
        mockDataGenerators[String(describing: [PostModel].self)] = {
            let mockPost = PostModel(
                id: 1,
                title: "Title",
                description: "This is a sample post description."
            )
            return [mockPost]
        }
    }
    
    func getData<T: Codable>(endPoint: EndPoints, model: T.Type, params: [String: Any]?, completion: @escaping (Result<T, CustomError>) -> Void) {
        DispatchQueue.main.async {
            if self.shouldReturnError {
                completion(.failure(.invalidResponse))
                return
            }
            
            if let mockDataGenerator = self.mockDataGenerators[String(describing: model)] {
                let mockData = mockDataGenerator()
                completion(.success(mockData as! T))
            } else {
                completion(.failure(.invalidData))
            }
        }
    }
}
