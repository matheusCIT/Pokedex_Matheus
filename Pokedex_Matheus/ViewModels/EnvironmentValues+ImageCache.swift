//
//  File.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 11/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
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
