//
//  NetworkRequest.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import Foundation

/// Defines network request.
struct NetworkRequest {
    /// Endpoint for request.
    var endpoint: Endpoint
    /// Type-safe HTTP method.
    var method: HTTPMethod = .get
    /// Type-safe HTTP headers.
    var httpHeaderFields: [HTTPHeader] = []
    /// The timeout interval of the request.
    var timeoutInterval: TimeInterval = 3
}
