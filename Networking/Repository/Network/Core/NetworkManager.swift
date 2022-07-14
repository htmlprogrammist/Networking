//
//  NetworkManager.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    var session: URLSession { get }
    var decoder: JSONDecoder { get }
    
    func handle<T>(response: URLResponse, content: T) throws -> T
}

/**
 Базовый класс, в котором расположена логика по обработке ответа сервера (URLResponse), от которого будут наследоваться конкретные загрузчики (модули)
 */
public class NetworkManager: NetworkManagerProtocol {
    
    let session: URLSession
    let decoder: JSONDecoder
    
    public init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    func handle<T>(response: URLResponse, content: T) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw "Unknown response received"
        }
        
        guard let httpStatusCode = HttpStatusCode(rawValue: response.statusCode) else {
            throw "Unknown http status code"
        }
        
        if httpStatusCode.isSuccessStatusCode {
            return content
        } else if let content = content as? Data {
            throw try decoder.decode(Request.Error.self, from: content)
        } else {
            throw Request.Error(code: response.statusCode)
        }
    }
}
