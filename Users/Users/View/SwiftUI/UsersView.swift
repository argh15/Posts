//
//  UsersView.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import SwiftUI

/// A view that displays a list of users.
struct UsersView: View {
    
    /// The view model that provides user data for this view.
    @ObservedObject var viewModel: UsersViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading users...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {

                    List(viewModel.users) { user in
                        NavigationLink(destination: UserDetailViewControllerRepresentable(userModel: user, viewModel: viewModel)) {
                            // A custom view cell for displaying user information.
                            UserCustomViewCell(name: user.name, username: user.username, email: user.email)
                        }
                    }
                }
            }
            // Fetch users when the view appears.
            .onAppear {
                viewModel.getUsers()
            }
        }
    }
}

#Preview {
    UsersView(viewModel: UsersViewModel(apiService: APIService()))
}
