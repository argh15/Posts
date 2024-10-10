//
//  PostsView.swift
//  Users
//
//  Created by Argh on 10/9/24.
//

import SwiftUI

struct PostsView: View {
    
    @ObservedObject var viewModel: PostsViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.posts) { post in
                PostCustomViewCell(title: post.title, description: post.description)
            }
            .navigationTitle(viewModel.userModel.name)
            .onAppear {
                viewModel.getPosts()
            }
        }
    }
}

#Preview {
    PostsView(viewModel: PostsViewModel(apiService: APIService(), userModel: UserModel(id: 1, name: "Test", username: "abc", email: "abc@xyz.com", address: Address(street: "Some St", suite: "999", city: "Some City", zipCode: "88899"), phone: "9999999999", website: "abc.com", company: Company(name: "CompName", catchPhrase: "Something"))))
}
