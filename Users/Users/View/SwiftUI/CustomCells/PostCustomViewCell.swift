//
//  PostCustomViewCell.swift
//  Users
//
//  Created by Argh on 10/9/24.
//

import SwiftUI

struct PostCustomViewCell: View {
    
    var title: String
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
