//
//  Endpoint.swift
//  Networking
//
//  Created by Егор Бадмаев on 15.07.2022.
//

import Foundation

/// An endpoint is an access to a route by a separate HTTP method. The endpoint performs a specific task, accepts parameters and returns data to the Client.
struct Endpoint {
    /// API key/token
    static let apiKey = "pk_aca08d8cf58e4441b8e436ef3646b1fb"

    /// Path to an endpoint
    let path: String
    /// Parameters for an endpoint
    var paratemets: [String: String] = [:]

    /// Property that computes the `url` of the instance
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "cloud.iexapis.com"
        components.path = "/" + path
        components.queryItems = paratemets.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components.url
    }
}
