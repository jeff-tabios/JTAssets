//
//  UIImageView+Cache.swift
//  JTGitSearch
//
//  Created by Jeff Tabios on 18/08/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit
import SVGKit

public enum ImageCachingStatus {
    case none
    case imageCached
    case cachedImageUsed
}

extension UIImageView {
    /// Loads image from web asynchronosly and caches it, in case you have to load url
    /// again, it will be loaded from cache if available
    func load(url: URL?, placeholder: UIImage?, cache: URLCache? = nil, completion: @escaping (ImageCachingStatus)->Void = {_ in }) {
        self.image = placeholder
        if let url = url {
            
            let cache = URLCache.shared
            let request = URLRequest(url: url)
            
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                self.image = image
                completion(.cachedImageUsed)
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            self.image = image
                            completion(.imageCached)
                        }
                    }
                }).resume()
            }
        }
        
    }
    
    func downloadedSVG(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let receivedicon: SVGKImage = SVGKImage(data: data),
                let image = receivedicon.uiImage
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
}

