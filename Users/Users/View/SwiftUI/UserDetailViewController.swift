//
//  UserDetailViewController.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    private let userModel: UserModel
    
    init(userModel: UserModel) {
        self.userModel = userModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print(userModel)
    }
}
