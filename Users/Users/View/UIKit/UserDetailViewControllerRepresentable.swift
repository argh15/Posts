//
//  UserDetailViewControllerRepresentable.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import SwiftUI
import UIKit

/// A struct that represents a UIViewController in SwiftUI for displaying user details.
struct UserDetailViewControllerRepresentable: UIViewControllerRepresentable {
    
    /// The user model containing details about the user.
    var userModel: UserModel
    /// The view model that manages user-related data and actions.
    var viewModel: UsersViewModel
    
    
    /// Creates and configures the UserDetailViewController instance.
    /// - Parameter context: The context provided by SwiftUI to manage the lifecycle of the UIViewController.
    /// - Returns: A configured instance of UserDetailViewController.
    func makeUIViewController(context: Context) -> UserDetailViewController {
        return UserDetailViewController(userModel: userModel, usersViewModel: viewModel)
    }
    
    /// Updates the specified UIViewController with new data from SwiftUI.
    /// - Parameters:
    ///   - uiViewController: The UIViewController to update.
    ///   - context: The context provided by SwiftUI to manage the lifecycle of the UIViewController.
    func updateUIViewController(_ uiViewController: UserDetailViewController, context: Context) {
        // No need to update for now
    }
}
