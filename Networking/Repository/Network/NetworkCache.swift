//
//  NetworkCache.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import Foundation

public protocol NetworkCache {
    associatedtype Item
    func save(object: Item?, for requestUrl: URL)
    func loadObject(for requestUrl: URL) -> Item?
    func hasCache(for requestUrl: URL) -> Bool
}
