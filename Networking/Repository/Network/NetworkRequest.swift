//
//  NetworkRequest.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import Foundation

struct NetworkRequest {
//    var urlString: String
    var method: HTTPMethod = .get
    var httpHeaderFields: [HTTPHeader] = []
    var parameters: [String: String] = [:]
}
