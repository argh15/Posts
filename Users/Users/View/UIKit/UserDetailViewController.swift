//
//  UserDetailViewController.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import UIKit
import SwiftUI

/// A view controller that displays detailed information about a user.
final class UserDetailViewController: UIViewController {
    
    /// The user model containing details about the user.
    private let userModel: UserModel
    /// The view model that manages user-related data and actions.
    private let usersViewModel: UsersViewModel
    
    /// Labels for displaying the user's address, phone, website, and company.
    private let address = UILabel()
    private let phone = UILabel()
    private let website = UILabel()
    private let company = UILabel()
    /// Button to navigate to the user's posts.
    private let goToPostsButton = UIButton(type: .system)
    
    /// Initializes a new UserDetailViewController with the specified user model and view model.
    /// - Parameters:
    ///   - userModel: The model containing user information.
    ///   - usersViewModel: The view model that manages user-related actions.
    init(userModel: UserModel, usersViewModel: UsersViewModel) {
        self.userModel = userModel
        self.usersViewModel = usersViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Called after the view controller has loaded its view hierarchy into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    /// Configures the user interface elements of the view controller.
    private func configureUI() {
        let nameLabel = createLabel(text: userModel.name, fontSize: 24, fontWeight: .bold)
        let addressStack = createLabelWithIcon(label: address, text: formatAddress(userModel.address), iconName: "mappin.and.ellipse")
        let phoneStack = createLabelWithIcon(label: phone, text: userModel.phone, iconName: "phone.fill")
        let websiteStack = createLabelWithIcon(label: website, text: userModel.website, iconName: "globe")
        let companyStack = createLabelWithIcon(label: company, text: formatCompany(userModel.company), iconName: "building.2.fill")
        
        // Stack view to hold all information labels
        let stackView = UIStackView(arrangedSubviews: [addressStack, phoneStack, websiteStack, companyStack])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        configureGoToPostsButton()  // Setup the button
        
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(nameLabel)
        mainView.addSubview(stackView)
        mainView.addSubview(goToPostsButton)
        
        view.addSubview(mainView) // Add main view to the controller's view
        
        // Set up Auto Layout constraints for the UI elements
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: mainView.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            goToPostsButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            goToPostsButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            goToPostsButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }
    
    /// Configures the "Go to Posts" button appearance and action.
    private func configureGoToPostsButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Go to Posts"
        configuration.baseBackgroundColor = .systemBlue
        configuration.baseForegroundColor = .white
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        configuration.cornerStyle = .medium
        
        goToPostsButton.configuration = configuration
        goToPostsButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Attach the button action
        goToPostsButton.addTarget(self, action: #selector(goToPostsButtonTapped), for: .touchUpInside)
    }
    
    /// Action triggered when the "Go to Posts" button is tapped.
    @objc private func goToPostsButtonTapped() {
        let postsViewModel = PostsViewModel(apiService: usersViewModel.apiService, userModel: userModel)
        let postsView = PostsView(viewModel: postsViewModel)
        let hostingController = UIHostingController(rootView: postsView)
        
        // Present the posts view controller
        self.present(hostingController, animated: true, completion: nil)
    }
    
    /// Formats the address for display.
    /// - Parameter address: The address to format.
    /// - Returns: A formatted address string.
    private func formatAddress(_ address: Address) -> String {
        return "\(address.street), \(address.suite), \(address.city), \(address.zipCode)"
    }
    
    /// Formats the company information for display.
    /// - Parameter company: The company to format.
    /// - Returns: A formatted company string.
    private func formatCompany(_ company: Company) -> String {
        return "\(company.name) - \(company.catchPhrase)"
    }
    
    /// Creates a UILabel with specified text, font size, and weight.
    /// - Parameters:
    ///   - text: The text to display in the label.
    ///   - fontSize: The font size of the label text.
    ///   - fontWeight: The font weight of the label text.
    /// - Returns: A configured UILabel instance.
    private func createLabel(text: String, fontSize: CGFloat, fontWeight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    /// Creates a UIStackView with an icon and a label.
    /// - Parameters:
    ///   - label: The UILabel to be included in the stack view.
    ///   - text: The text to display in the label.
    ///   - iconName: The name of the icon image to display.
    /// - Returns: A UIStackView containing the icon and label.
    private func createLabelWithIcon(label: UILabel, text: String, iconName: String) -> UIStackView {
        let iconImageView = UIImageView(image: UIImage(systemName: iconName))
        iconImageView.tintColor = .systemBlue
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        label.text = text
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView, label])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
}
