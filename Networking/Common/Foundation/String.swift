//
//  String.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import Foundation

extension String: UrlCreatable {
    public func createUrl() throws -> URL {
        if let url = URL(string: self) {
            return url
        } else {
            throw "Cannot create url"
        }
    }
}
