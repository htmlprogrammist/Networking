//
//  IEXEndpoints.swift
//  Networking
//
//  Created by Егор Бадмаев on 15.07.2022.
//

/// Here you can see endpoints for current API - _"IEXCloud"_
extension Endpoint {
    static func mostactive() -> Self {
        return Endpoint(path: "stable/stock/market/list/mostactive",
                        paratemets: ["token": apiKey]
        )
    }
    
    static func stock(for company: String) -> Self {
        return Endpoint(path: "stock/\(company)/quote",
                        paratemets: ["token": apiKey]
        )
    }
    
    static func logo(for company: String) -> Self {
        return Endpoint(path: "stock/\(company)/logo",
                        paratemets: ["token": apiKey]
        )
    }
}
