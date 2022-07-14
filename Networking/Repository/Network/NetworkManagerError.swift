//
//  NetworkManagerError.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

enum NetworkManagerError: Error {
    case invalidURL
    case retainCycle
    case networkError
    case parsingJSONError
}
