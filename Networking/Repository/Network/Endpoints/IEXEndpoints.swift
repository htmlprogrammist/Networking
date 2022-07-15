//
//  IEXEndpoints.swift
//  Networking
//
//  Created by Егор Бадмаев on 15.07.2022.
//

import Foundation

extension Endpoint {
//    var stocksURLs = ["https://cloud.iexapis.com/stable/stock/market/list/mostactive?&token=pk_aca08d8cf58e4441b8e436ef3646b1fb",
//                      "https://cloud.iexapis.com/stable/stock/AAPL/quote?&token=pk_aca08d8cf58e4441b8e436ef3646b1fb",
//                      "https://cloud.iexapis.com/stable/stock/AAPL/logo?&token=pk_aca08d8cf58e4441b8e436ef3646b1fb"]
    static func mostactive() -> Self {
        return Endpoint(
            path: "stable/stock/market/list/mostactive",
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
