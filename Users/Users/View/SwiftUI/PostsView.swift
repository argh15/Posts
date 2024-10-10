//
//  PostsView.swift
//  Users
//
//  Created by Argh on 10/9/24.
//

import SwiftUI

/// A view that displays a list of posts for a specific user.
struct PostsView: View {
    
    /// The view model that provides post data and user information for this view.
    @ObservedObject var viewModel: PostsViewModel
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView("Loading posts ...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.posts) { post in
                        // A custom view cell for displaying post information.
                        PostCustomViewCell(title: post.title, description: post.description)
                    }
                    .navigationTitle(viewModel.userModel.name)
                }
            }
        }
        // Fetch posts when the view appears.
        .onAppear {
            viewModel.getPosts()
        }
    }
}

#Preview {
    PostsView(viewModel: PostsViewModel(apiService: APIService(), userModel: UserModel(id: 1, name: "Test", username: "abc", email: "abc@xyz.com", address: Address(street: "Some St", suite: "999", city: "Some City", zipCode: "88899"), phone: "9999999999", website: "abc.com", company: Company(name: "CompName", catchPhrase: "Something"))))
}
