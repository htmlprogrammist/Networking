//
//  CachedStorage.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import Foundation

public class CachedStorage {
    
    private let fileManager: FileManager = .default
    
    public func save(data: Data?, at url: URL) {
        let directoryUrl = url.deletingLastPathComponent()
        
        if !directoryExistsAtPath(directoryUrl.path) {
            createCacheDirectory(at: directoryUrl)
        }
        
        fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
    }
    
    public func loadData(at url: URL) -> Data? {
        return try? Data(contentsOf: url)
    }
    
    public func hasCache(at url: URL) -> Bool {
        return fileManager.fileExists(atPath: url.path)
    }
    
    private func directoryExistsAtPath(_ path: String) -> Bool {
        var isDirectory = ObjCBool(true)
        let exists = fileManager.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
    
    private func createCacheDirectory(at url: URL) {
        do {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
        } catch {
            assertionFailure("Cache directory not created: \(error.localizedDescription)")
        }
    }
    
    public func cachesUrl() -> URL {
        let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        
        if let url = urls.first {
            return url
        } else {
            return fileManager.temporaryDirectory
        }
    }
}
