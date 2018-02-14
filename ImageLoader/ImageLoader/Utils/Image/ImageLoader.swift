//
//  ImageLoader.swift
//  ImageLoader
//
//  Created by Andrew Chupin on 14.02.2018.
//  Copyright © 2018 Andrew Chupin. All rights reserved.
//

import Foundation
import UIKit


// Abstraction for image request
// Using inside ImageRequest
protocol ImageRequest {}


// Abstraction for image loading
protocol ImageLoader {
    func loadImage(by request: ImageRequest)
}


/// Concurent [ImageRequest], using for [PlaceholderTableViewCell]
struct PlaceholderImageRequest: ImageRequest {
    let url: String
    let cell: UITableViewCell
}


/// Concurent [ImageLoader] for [PlaceholderImageRequest]
/// If cache is empty, get [NSData], by [ImageRequest] from Network
/// Before loading save image inside [NSCashe]
class PlaceholderImageLoader: ImageLoader {
    
    private let cache = NSCache<NSURL, NSData>()
    
    /// Configure [NSCache]
    init() {
        cache.countLimit = 100
    }
    
    // Get strategy for loading image Network or cache
    func loadImage(by request: ImageRequest) {
        
        guard let placeholderRequest = request as? PlaceholderImageRequest else {
            return
        }
        
        guard let placeholerCell = placeholderRequest.cell as? PlaceholderTableViewCell else {
            return
        }
        
        let urlPath = placeholderRequest.url
        
        if let cache = fromCache(with: urlPath) {
            placeholerCell.imageView?.image = UIImage(data: cache as Data)
        } else {
            if let url = URL(string: urlPath) {
                placeholerCell.url = url
                downloadImage(withUrl: url, forCell: placeholerCell)
            }
        }
    }
    
    
    
    /// Get [NSData] by key [NSCache] but if not founded return nul
    ///
    /// - Parameter urlPath: key for [NSCache]
    /// - Returns: optional [NSData]
    private func fromCache(with urlPath: String) -> NSData? {
        if let url = NSURL(string: urlPath) {
            let cachedData = cache.object(forKey: url)
            return cachedData
        }
        return nil
    }
    
    
    
    /// Load data from Network, saving inside [NSCache] and validate [UITableViewCell]
    ///
    /// - Parameters:
    ///   - url: [URL] for loading from Network
    ///   - cell: [UITableViewCell] for put [NSData] through [UIImage]
    private func downloadImage(withUrl url: URL, forCell cell: UITableViewCell) {
        guard let placeholerCell = cell as? PlaceholderTableViewCell else {
            return
        }
        
        DispatchQueue.global(qos: .utility).async {
            let imageData: NSData = NSData(contentsOf: url)!
            DispatchQueue.main.async {
                if let urlKey = NSURL(string: url.absoluteString) {
                    self.cache.setObject(imageData, forKey: urlKey)
                }
                if (placeholerCell.url == url) {
                    let image = UIImage(data: imageData as Data)
                    cell.imageView?.image = image
                    cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
                    cell.setNeedsLayout()
                }
            }
        }
    }
    
}
