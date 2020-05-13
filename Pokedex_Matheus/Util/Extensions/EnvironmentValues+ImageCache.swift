//
//  EnvironmentValues+ImageCache.swift
//  AsyncImage
//
//  Created by Vadim Bulavin on 3/24/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import SwiftUI

public struct ImageCacheKey: EnvironmentKey {
    
    /// Returns a temporary image cahe
    public static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    
    /// Overrides ImageCache get and set
    public var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
