//
//  HTTPMethod.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

/// Type-safe HTTP-method
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
