//
//  ImagesStorage.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import UIKit

public final class ImagesStorage: CachedStorage, NetworkCache {
    
    public func save(object: UIImage?, for requestUrl: URL) {
        let data = object?.pngData()
        let url = fileUrl(for: requestUrl)
        save(data: data, at: url)
    }
    
    public func loadObject(for requestUrl: URL) -> UIImage? {
        let url = fileUrl(for: requestUrl)
        
        if let data = loadData(at: url) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
    
    public func hasCache(for requestUrl: URL) -> Bool {
        let url = fileUrl(for: requestUrl)
        return hasCache(at: url)
    }
    
    public func fileUrl(for requestUrl: URL) -> URL {
        let url = cachesUrl()
        let className = String(describing: Self.self)
        let hash = (requestUrl.absoluteString as NSString).hash
        
        return url
            .appendingPathComponent(className)
            .appendingPathComponent(String(hash))
            .appendingPathComponent(requestUrl.lastPathComponent)
    }
}
