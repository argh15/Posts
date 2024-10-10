//
//  UsersApp.swift
//  Users
//
//  Created by Argh on 10/9/24.
//

import SwiftUI

@main
struct UsersApp: App {
    
    @StateObject private var usersViewModel: UsersViewModel
    
    init() {
        let apiService: APIServiceProtocol = APIService()
        _usersViewModel = StateObject(wrappedValue: UsersViewModel(apiService: apiService))
    }
    
    var body: some Scene {
        WindowGroup {
            UsersView(viewModel: usersViewModel)
        }
    }
}
