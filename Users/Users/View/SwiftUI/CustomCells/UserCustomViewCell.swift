//
//  UserCustomViewCell.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import SwiftUI

struct UserCustomViewCell: View {
    
    var name: String
    var username: String
    var email: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline)
                .foregroundStyle(.primary)
                .padding(.bottom, 4)
            HStack {
                Text(username)
                Text("|")
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
