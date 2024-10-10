//
//  UserModel.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import Foundation

struct UserModel: Decodable, Identifiable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

struct Address: Decodable {
    let street, suite, city, zipCode: String
    
    enum CodingKeys: String, CodingKey {
        case street, suite, city
        case zipCode = "zipcode"
    }
}


struct Company: Decodable {
    let name, catchPhrase: String
}

