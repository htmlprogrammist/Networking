//
//  Request.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import Foundation

public final class Request {
    
    private(set) var urlRequest: URLRequest
    
    init(url: URL, method: HTTPMethod, headers: [HTTPHeader], parameters: Parameters?) throws {
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers.reduce(into: [:]) { $0[$1.name] = $1.value }
        
        if let parameters = parameters {
            try encode(parameters: parameters)
        }
    }
    
    func encodeQuery(boolean value: Bool, encoding: Parameters.Configuration.BoolEncoding) -> String {
        switch encoding {
        case .numeric:
            return (value as NSNumber).stringValue
        case .literal:
            return String(value)
        }
    }
    
    // MARK: - Private methods
    private func encode(parameters: Parameters) throws {
        switch parameters.configuration.destination {
        case .query(let arrayEncoding, let boolEncoding):
            try appendQuery(parameters: parameters, arrayEncoding: arrayEncoding, boolEncoding: boolEncoding)
        case .httpBody:
            try addHttpBody(parameters: parameters)
        }
    }
    
    private func appendQuery(parameters: Parameters,
                             arrayEncoding: Parameters.Configuration.ArrayEncoding,
                             boolEncoding: Parameters.Configuration.BoolEncoding) throws {
        guard let dictionary = parameters.object as? [String: Any] else {
            throw "Query parameters is not [String: Any] dictionary"
        }
        
        guard let url = urlRequest.url,
              var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else {
            throw "Cannot create url components from url request"
        }
        
        for (name, value) in dictionary {
            let items = createQueryItems(
                name: name,
                value: value,
                arrayEncoding: arrayEncoding,
                boolEncoding: boolEncoding
            )
            
            var queryItems = components.queryItems ?? []
            queryItems.append(contentsOf: items)
            components.queryItems = queryItems
        }
        
        if let url = components.url {
            urlRequest.url = url
        }
        
        if parameters.configuration.updateHeaders {
            var headers = urlRequest.allHTTPHeaderFields ?? [:]
            headers["Content-Type"] = "application/x-www-form-urlencoded; charset=utf-8"
            urlRequest.allHTTPHeaderFields = headers
        }
    }
    
    private func addHttpBody(parameters: Parameters) throws {
        if let data = parameters.object as? Data {
            urlRequest.httpBody = data
        } else if JSONSerialization.isValidJSONObject(parameters.object) {
            let data = try JSONSerialization.data(withJSONObject: parameters.object, options: .fragmentsAllowed)
            urlRequest.httpBody = data
        }
        
        if parameters.configuration.updateHeaders {
            var headers = urlRequest.allHTTPHeaderFields ?? [:]
            headers["Content-Type"] = "application/json; charset=utf-8"
            urlRequest.allHTTPHeaderFields = headers
        }
    }
    
    private func createQueryItems(name: String,
                                  value: Any,
                                  arrayEncoding: Parameters.Configuration.ArrayEncoding,
                                  boolEncoding: Parameters.Configuration.BoolEncoding) -> [URLQueryItem] {
        switch value {
        case let boolean as Bool:
            let value = encodeQuery(boolean: boolean, encoding: boolEncoding)
            let queryItem = URLQueryItem(name: name, value: value)
            return [queryItem]
        case let number as NSNumber:
            let queryItem = URLQueryItem(name: name, value: number.stringValue)
            return [queryItem]
        case let array as [Any]:
            let name = encodeQuery(array: name, encoding: arrayEncoding)
            let queryItems = array.flatMap { value in
                createQueryItems(name: name, value: value, arrayEncoding: arrayEncoding, boolEncoding: boolEncoding)
            }
            return queryItems
        case let dictionary as [String: Any]:
            let queryItems: [[URLQueryItem]] = dictionary.map { key, value in
                let name = name + "[\(key)]"
                return createQueryItems(name: name, value: value, arrayEncoding: arrayEncoding, boolEncoding: boolEncoding)
            }
            return queryItems.flatMap { $0 }
        default:
            let queryItem = URLQueryItem(name: name, value: "\(value)")
            return [queryItem]
        }
    }
    
    private func encodeQuery(array name: String, encoding: Parameters.Configuration.ArrayEncoding) -> String {
        switch encoding {
        case .brackets:
            return name + "[]"
        case .noBrackets:
            return name
        }
    }
}
