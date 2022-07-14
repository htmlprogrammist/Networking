//
//  UrlCreatable.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import Foundation

public protocol UrlCreatable {
    func createUrl() throws -> URL
}

extension URL: UrlCreatable {
    public func createUrl() throws -> URL {
        return self
    }
}
