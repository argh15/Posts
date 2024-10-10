//
//  UserCustomViewCell.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import SwiftUI

/// A view that displays a custom cell for user information.
struct UserCustomViewCell: View {
    
    /// The name of the user.
    var name: String
    /// The username of the user.
    var username: String
    /// The email address of the user.
    var email: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline)
                .foregroundStyle(.primary)
                .padding(.bottom, 4)
            HStack {
                Text(username)
                Text("|")  // Separator between username and email
                Text(email)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    UserCustomViewCell(name: "John Doe", username: "john_doe", email: "john@example.com")
}
