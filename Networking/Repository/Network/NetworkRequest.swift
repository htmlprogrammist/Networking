//
//  NetworkRequest.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

struct NetworkRequest {
    var endpoint: Endpoint
    var method: HTTPMethod = .get
    var httpHeaderFields: [HTTPHeader] = []
}
