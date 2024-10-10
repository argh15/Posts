//
//  PostsViewModel.swift
//  Users
//
//  Created by Argh on 10/9/24.
//

import Foundation

/// A view model that manages post data for a specific user and handles data fetching from the API.
final class PostsViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private var apiService: APIServiceProtocol!
    var userModel: UserModel!
    
    /// Initializes the view model with an API service and a user model.
    /// - Parameters:
    ///   - apiService: The API service used for fetching post data.
    ///   - userModel: The user whose posts are to be fetched.
    init(apiService: APIServiceProtocol, userModel: UserModel) {
        self.apiService = apiService
        self.userModel = userModel
    }
    
    /// Fetches posts for the specified user from the API service.
    func getPosts() {
        isLoading = true
        apiService.getData(
            endPoint: .posts,
            model: [PostModel].self,
            params: ["userId": userModel.id]
        ) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let posts):
                    self?.posts = posts
                case .failure(let error):
                    self?.errorMessage = "Error fetching posts: \(error.localizedDescription)"
                    print(self?.errorMessage ?? "Unknown error")
                }
            }
        }
    }
}
