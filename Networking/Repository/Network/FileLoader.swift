//
//  FileLoader.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import Foundation

public final class FileLoader: NetworkManager {
    
    public init(session: URLSession) {
        super.init(session: session, decoder: JSONDecoder())
    }
    
    @discardableResult
    public func downloadRequest(url: UrlCreatable, method: HTTPMethod, headers: [HTTPHeader] = [], parameters: Request.Parameters? = nil) async throws -> URL {
        let url = try url.createUrl()
        
        let request = try Request(
            url: url,
            method: method,
            headers: headers,
            parameters: parameters
        )
        
        let (fileUrl, response) = try await session.download(for: request.urlRequest)
        return try handle(response: response, content: fileUrl)
    }
}
