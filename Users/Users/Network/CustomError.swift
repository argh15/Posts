//
//  CustomError.swift
//  Posts
//
//  Created by Argh on 10/9/24.
//

import Foundation

enum CustomError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The url is invalid!"
        case .invalidResponse:
            return "The response is invalid!"
        case .invalidData:
            return "The parsing of data failed!"
        }
    }
}
