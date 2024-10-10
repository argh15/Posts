//
//  PostModel.swift
//  Users
//
//  Created by Argh on 10/9/24.
//


struct PostModel: Decodable, Identifiable {
    
    let id: Int
    let title, description: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case description = "body"
    }
}

