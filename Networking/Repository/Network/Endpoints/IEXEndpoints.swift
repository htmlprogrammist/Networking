//
//  IEXEndpoints.swift
//  Networking
//
//  Created by Егор Бадмаев on 15.07.2022.
//

import Foundation

extension Endpoint {
    static func mostactive() -> Self {
        return Endpoint(path: "stable/stock/market/list/mostactive",
                        queryItems: [
                            URLQueryItem(name: "token", value: apiKey)
                        ]
        )
    }
    
    static func stock(for company: String) -> Self {
        return Endpoint(path: "stock/\(company)/quote",
                        queryItems: [
                            URLQueryItem(name: "token", value: apiKey)
                        ]
        )
    }
    
    static func logo(for company: String) -> Self {
        return Endpoint(path: "stock/\(company)/logo",
                        queryItems: [
                            URLQueryItem(name: "token", value: apiKey)
                        ]
        )
    }
}
