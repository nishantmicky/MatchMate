//
//  ImageDownloadManager.swift
//  MatchMate
//
//  Created by Nishant Kumar on 01/03/25.
//

import UIKit
import SDWebImage

class ImageDownloadManager {
    
    static let shared = ImageDownloadManager()
        
    private init() {}

    func downloadImages(from urls: [String]) {
        for urlString in urls {
            guard let url = URL(string: urlString) else {
                continue
            }
            
            SDWebImageManager.shared.loadImage(with: url, options: .highPriority, progress: nil) { image, _, _, _, _, _ in
                if let downloadedImage = image {
                    self.saveImageToDisk(image: downloadedImage, url: url)
                }
            }
        }
    }
    
    func fetchImageFromCache(url: String) -> UIImage? {
        return SDImageCache.shared.imageFromDiskCache(forKey: url)
    }

    private func saveImageToDisk(image: UIImage, url: URL) {
        SDImageCache.shared.store(image, forKey: url.absoluteString, toDisk: true)
        print("Image saved to disk at URL: \(url.absoluteString)")
    }
}
