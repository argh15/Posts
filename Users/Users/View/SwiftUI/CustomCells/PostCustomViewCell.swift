//
//  PostCustomViewCell.swift
//  Users
//
//  Created by Argh on 10/9/24.
//

import SwiftUI

/// A view that displays a custom cell for post information.
struct PostCustomViewCell: View {
    
    /// The title of the post.
    var title: String
    /// The description of the post.
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)
                .padding(.bottom, 4)
            Text(description)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    PostCustomViewCell(title: "Title", description: "This is some dummy description.")
}
