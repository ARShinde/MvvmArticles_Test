import UIKit

let imageCache = NSCache<NSString, AnyObject>()

// Responsible for caching image using NSURLSession
extension UIImageView {
  func downloadImageFrom(url: URL) {
    contentMode = UIView.ContentMode.scaleAspectFill
    if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
      image = cachedImage
    } else {
      URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
          return
        }
        DispatchQueue.main.async {
          let imageToCache = UIImage(data: data)
          imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
          self.image = imageToCache
        }
      }.resume()
    }
  }
}
