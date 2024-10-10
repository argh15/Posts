//
//  UsersView.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import SwiftUI

struct UsersView: View {
    
    @ObservedObject var viewModel: UsersViewModel

    var body: some View {
            NavigationStack {
                List(viewModel.users) { user in
                    NavigationLink(destination: UserDetailViewControllerRepresentable(userModel: user, viewModel: viewModel)) {
                        UserCustomViewCell(name: user.name, username: user.username, email: user.email)
                    }
                }
                .onAppear {
                    viewModel.getUsers()
                }
            }
        }
}

#Preview {
    UsersView(viewModel: UsersViewModel(apiService: APIService()))
}
