//
//  UsersViewModel.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import Foundation

final class UsersViewModel: ObservableObject {
    
    @Published var users: [UserModel] = []
    var apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func getUsers() {
        apiService.getData(endPoint: .users, model: [UserModel].self, params: nil) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.users = users
                case .failure(let error):
                    print("Error fetching users: \(error.localizedDescription)")
                }
            }
        }
    }
}
