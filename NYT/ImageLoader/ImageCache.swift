//
//  ImageCache.swift
//  NYT
//
//  to speed up the development process, the code is borrowed from open sources
//  the source -> Async Image Loading Example (iOS)
//
//  Created by Artem Mkrtchyan on 3/24/21.
//

import UIKit
public class ImageCache {
    
    public static let publicCache = ImageCache()
    var placeholderImage = UIImage(named: "nyt_placeholder")!
    private let cachedImages = NSCache<NSURL, UIImage>()
    private var loadingResponses = [NSURL: [(Item, UIImage?) -> Swift.Void]]()
    
    public final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    /// - Tag: cache
    // Returns the cached image if available, otherwise asynchronously loads and caches it.
    final func load(url: NSURL, item: Item, completion: @escaping (Item, UIImage?) -> Swift.Void) {
        // Check for a cached image.
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(item, cachedImage)
            }
            return
        }
        // In case there are more than one requestor for the image, we append their completion block.
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }
        // Go fetch the image.
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = ApiConstants.timeOut
        
        let task = URLSession(configuration: sessionConfig).dataTask(with: url as URL) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  (200 ..< 300) ~= response.statusCode,
                  error == nil else {
                print(response)    // need to fix
                return
            }
            do {
                guard let image = UIImage(data: data),
                      let blocks = self.loadingResponses[url], error == nil else {
                    DispatchQueue.main.async {
                        completion(item, nil)
                    }
                    return
                }
                // Cache the image.
                self.cachedImages.setObject(image, forKey: url, cost: data.count)
                // Iterate over each requestor for the image and pass it back.
                for block in blocks {
                    DispatchQueue.main.async {
                        block(item, image)
                    }
                    return
                }
            }
        }
        task.resume()
    }
    
}
