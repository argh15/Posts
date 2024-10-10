//
//  APIConstants.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import Foundation

struct APIConstants {
    
    let baseURL = "https://jsonplaceholder.typicode.com"
}

enum EndPoints: String {
    case users = "/users"
    case posts = "/posts"
}
