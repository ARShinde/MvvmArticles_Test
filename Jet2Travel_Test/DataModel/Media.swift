
// Model class represents media data
//struct Media: Codable {
//  let contentID: String
//  let blogID: String
//  let createdDate: String
//  let image: String
//  let title: String
//  let url: String
//
//  enum CodingKeys: String, CodingKey {
//    case image, title, url
//    case contentID = "id"
//    case blogID = "blogId"
//    case createdDate = "createdAt"
//  }
//}


// MARK: - Media
struct Media: Codable {
    let id, blogID, createdAt: String
    let image: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case blogID = "blogId"
        case createdAt, image, title, url
    }
}
