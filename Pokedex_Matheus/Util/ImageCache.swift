//
//  ImageCache.swift
//  AsyncImage
//
//  Created by Vadym Bulavin on 2/19/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import UIKit

public protocol ImageCache {
    
    /// Subscript
    /// - Parameter url: The resource url
    subscript(_ url: String) -> UIImage? { get set }
}

public struct TemporaryImageCache: ImageCache {
    
    // MARK: Properties
    
    private let cache = NSCache<NSString, UIImage>()
    
    // MARK: Image cacue
    
    public subscript(_ key: String) -> UIImage? {
        get { cache.object(forKey: key as NSString) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSString) : cache.setObject(newValue!, forKey: key as NSString) }
    }
}
