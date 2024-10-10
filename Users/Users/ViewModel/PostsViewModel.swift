//
//  PostsViewModel.swift
//  Users
//
//  Created by Argh on 10/9/24.
//

import Foundation

final class PostsViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    private var apiService: APIService!
    var userModel: UserModel!
    
    init(apiService: APIService, userModel: UserModel) {
        self.apiService = apiService
        self.userModel = userModel
    }
    
    func getPosts() {
        apiService.getData(
            endPoint: .posts,
            model: [PostModel].self,
            params: ["userId": userModel.id]
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self?.posts = posts
                case .failure(let error):
                    print("Error fetching posts: \(error.localizedDescription)")
                }
            }
        }
    }
}
