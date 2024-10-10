//
//  UserDetailViewControllerRepresentable.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import SwiftUI
import UIKit

struct UserDetailViewControllerRepresentable: UIViewControllerRepresentable {
    
    var userModel: UserModel
    var viewModel: UsersViewModel
    
    func makeUIViewController(context: Context) -> UserDetailViewController {
        return UserDetailViewController(userModel: userModel, usersViewModel: viewModel)
    }
    
    func updateUIViewController(_ uiViewController: UserDetailViewController, context: Context) {
        // No need to update for now
    }
}
