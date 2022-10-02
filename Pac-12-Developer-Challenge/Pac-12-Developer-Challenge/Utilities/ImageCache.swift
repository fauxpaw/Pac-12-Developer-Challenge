import UIKit

class URLKey {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

let imageCache = NSCache<URLKey, UIImage>()
