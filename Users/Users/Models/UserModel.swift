//
//  UserModel.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import Foundation

struct UserModel: Codable, Identifiable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

struct Address: Codable {
    let street, suite, city, zipCode: String
    
    enum CodingKeys: String, CodingKey {
        case street, suite, city
        case zipCode = "zipcode"
    }
}


struct Company: Codable {
    let name, catchPhrase: String
}

