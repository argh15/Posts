//
//  UsersApp.swift
//  Users
//
//  Created by Argh on 10/9/24.
//

import SwiftUI

@main
struct UsersApp: App {
    
    /// A state object that holds the view model for managing user data.
    @StateObject private var usersViewModel: UsersViewModel
    
    /// Initializes the UsersApp with a default API service.
    init() {
        /// Create an instance of APIService that conforms to APIServiceProtocol.
        let apiService: APIServiceProtocol = APIService()
        /// Initialize the usersViewModel with the created apiService.
        _usersViewModel = StateObject(wrappedValue: UsersViewModel(apiService: apiService))
    }
    
    var body: some Scene {
        WindowGroup {
            /// Pass the view model to the UsersView for data binding.
            UsersView(viewModel: usersViewModel)
        }
    }
}
