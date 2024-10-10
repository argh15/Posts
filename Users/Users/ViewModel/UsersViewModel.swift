//
//  UsersViewModel.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import Foundation

/// A view model that manages user data and handles data fetching from the API.
final class UsersViewModel: ObservableObject {
    
    @Published var users: [UserModel] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    var apiService: APIServiceProtocol // Service for API calls.
    
    /// Initializes the view model with an API service.
    /// - Parameter apiService: The API service used for fetching user data.
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    /// Fetches users from the API service.
    func getUsers() {
        isLoading = true
        apiService.getData(endPoint: .users, model: [UserModel].self, params: nil) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let users):
                    self?.users = users
                case .failure(let error):
                    self?.errorMessage = "Error fetching users: \(error.localizedDescription)"
                    print(self?.errorMessage ?? "Unknown error")
                }
            }
        }
    }
}
