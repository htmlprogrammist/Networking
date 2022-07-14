//
//  URLSession.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import Foundation

extension URLSession {
    static let `default`: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForResource = configuration.timeoutIntervalForRequest
        return URLSession(configuration: configuration)
    }()
    
    static let background: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "background-session")
        return URLSession(configuration: configuration)
    }()
}
