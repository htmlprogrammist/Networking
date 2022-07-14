//
//  ImageLoader.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import UIKit

public actor ImageLoader {
    
    private let fileLoader: FileLoader
    private let storage = ImagesStorage()
    
    public init(session: URLSession) {
        fileLoader = FileLoader(session: session)
    }
    
    public func loadImage(at url: URL) async -> UIImage? {
        if let image = storage.loadObject(for: url) {
            return image
        } else {
            let image: UIImage? = try? await downloadImage(url: url)
            storage.save(object: image, for: url)
            return image
        }
    }
    
    public func createThumb(of image: UIImage?, size: CGSize) async -> UIImage? {
        guard let image = image else {
            return nil
        }
        
        let ratio = image.size.width / image.size.height
        let width: CGFloat
        let height: CGFloat
        
        if image.size.width > image.size.height {
            width = size.width
            height = width / ratio
        } else {
            height = size.height
            width = ratio * height
        }
        
        let size = CGSize(width: width, height: height)
        return await image.byPreparingThumbnail(ofSize: size)
    }
    
    public func fileUrl(forImageAt url: URL) async -> URL? {
        return storage.fileUrl(for: url)
    }
    
    @discardableResult
    public func downloadImage(url: UrlCreatable,
                              method: HTTPMethod = .get,
                              headers: [HTTPHeader] = [],
                              parameters: Request.Parameters? = nil) async throws -> Image? {
        let uiImage: UIImage? = try await downloadImage(
            url: url,
            method: method,
            headers: headers,
            parameters: parameters
        )
        
        if let uiImage = uiImage {
            return Image(uiImage: uiImage)
        } else {
            return nil
        }
    }
    
    @discardableResult
    public func downloadImage(url: UrlCreatable,
                              method: HTTPMethod = .get,
                              headers: [HTTPHeader] = [],
                              parameters: Request.Parameters? = nil) async throws -> UIImage? {
        let fileUrl = try await fileLoader.downloadRequest(
            url: url,
            method: method,
            headers: headers,
            parameters: parameters
        )
        
        return UIImage(contentsOfFile: fileUrl.path)
    }
}
