import UIKit

class Router {
  private enum NetworkConstants {
    static let scheme = "https"
    static let host = "5e99a9b1bc561b0016af3540.mockapi.io"
    static let path = "/jet2/api/v1/blogs"
    static let method = "GET"
  }

  static func getAllArticles(pageIndex: Int, completion: @escaping (Result<[Article], Error>) -> ()) {
    var components = URLComponents()
    components.scheme = NetworkConstants.scheme
    components.host = NetworkConstants.host
    components.path = NetworkConstants.path
    components.queryItems = [URLQueryItem(name: "page", value: "\(pageIndex)"), URLQueryItem(name: "limit", value: "10")]

    guard let url = components.url else { return }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = NetworkConstants.method
    
    NetworkManager.shared.callAPI(request: urlRequest) { (result: Result<[Article], Error>) in
      completion(result)
    }
  }
}
