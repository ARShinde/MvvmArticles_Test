import Foundation
import UIKit

class NetworkManager {

  static let shared = NetworkManager()
  private init() { }

  let session = URLSession(configuration: .default)
  
  func callAPI<T:Codable> (request: URLRequest, completion: @escaping (Result<T,Error>)-> ()) {
    session.dataTask(with: request) { (data, response, error) in
      guard error == nil else {
        completion(.failure(error!))
        return
      }
      guard response != nil else {
        completion(.failure(error!))
        return
      }
      guard let data = data else {
        return
      }
      print(data.debugDescription)
      let response = try! JSONDecoder().decode(T.self, from: data)
      DispatchQueue.main.async {
        completion(.success(response))
      }
    }.resume()
  }
}
