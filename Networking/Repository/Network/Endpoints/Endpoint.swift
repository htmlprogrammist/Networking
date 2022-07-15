//
//  Endpoint.swift
//  Networking
//
//  Created by Егор Бадмаев on 15.07.2022.
//

import Foundation

struct Endpoint {
    static let apiKey = "pk_aca08d8cf58e4441b8e436ef3646b1fb"
    
    let path: String
    var queryItems: [URLQueryItem] = []
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "cloud.iexapis.com"
        components.path = "/" + path
        components.queryItems = queryItems
        return components.url
    }
}
