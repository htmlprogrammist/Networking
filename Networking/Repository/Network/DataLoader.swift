//
//  DataLoader.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import Foundation

final class DataLoader: NetworkManager {
    @discardableResult
    public func dataRequest<T: Decodable>(url: UrlCreatable, method: HTTPMethod, headers: [HTTPHeader] = [], parameters: Request.Parameters? = nil) async throws -> T {
        
        let data = try await dataRequest(
            url: url,
            method: method,
            headers: headers,
            parameters: parameters
        )
        
        return try decoder.decode(T.self, from: data)
    }
    
    @discardableResult
    public func dataRequest(url: UrlCreatable, method: HTTPMethod, headers: [HTTPHeader] = [], parameters: Request.Parameters? = nil) async throws -> Data {
        let url = try url.create()
        
        let request = try Request(url: url, method: method, headers: headers, parameters: parameters)
        
        let (data, response) = try await session.data(for: request.urlRequest)
        return try handle(response: response, content: data)
    }
}

extension DataLoader {
    convenience init(session: URLSession = .default) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        self.init(session: session, decoder: decoder)
    }
    
    private func baseUrl() throws -> URL {
        guard let host = Bundle.main.object(forInfoDictionaryKey: "Host") as? String else {
            throw "Host variable is not secified"
        }
        
        guard let url = URL(string: host) else {
            throw "Cannot create url"
        }
        
        return url.appendingPathComponent("swagger")
    }
    
    private var accessToken: String {
        let secureSettings = SecureSettings()
        return secureSettings.accessToken ?? ""
    }
    
    @discardableResult
    public func dataRequest(path: String, method: HTTPMethod, headers: [HTTPHeader] = [], parameters: Request.Parameters? = nil) async throws -> Data {
        let url = try baseUrl().appendingPathComponent(path)
        
        return try await dataRequest(
            url: url,
            method: method,
            headers: headers,
            parameters: parameters
        )
    }
    
    @discardableResult
    public func dataRequest<T: Decodable>(path: String, method: HTTPMethod, headers: [HTTPHeader] = [], parameters: Request.Parameters? = nil) async throws -> T {
        let url = try baseUrl().appendingPathComponent(path)
        
        return try await dataRequest(
            url: url,
            method: method,
            headers: headers,
            parameters: parameters
        )
    }
}

extension DataLoader {
    func login(userName: String, password: String) async throws -> LoginResponse {
        return try await dataRequest(
            path: "auth/login",
            method: .get,
            parameters: ["userName": username, "password": password]
        )
    }
}
