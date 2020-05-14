import UIKit

public protocol ImageCache {
    subscript(_ url: String) -> UIImage? { get set }
}

public struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSString, UIImage>()
    
    public subscript(_ key: String) -> UIImage? {
        get { cache.object(forKey: key as NSString) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSString) : cache.setObject(newValue!, forKey: key as NSString) }
    }
}
