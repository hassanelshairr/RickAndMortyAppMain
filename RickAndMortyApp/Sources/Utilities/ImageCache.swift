//
//  ImageCache.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 28/08/2025.
//

import UIKit

final class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSURL, UIImage>()

    private init() {}

    func image(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }

    func insert(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }

    func load(_ url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cached = image(for: url) {
            completion(cached); return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            var img: UIImage? = nil
            if let data = data { img = UIImage(data: data) }
            if let img = img { self.insert(img, for: url) }
            DispatchQueue.main.async { completion(img) }
        }.resume()
    }
}
