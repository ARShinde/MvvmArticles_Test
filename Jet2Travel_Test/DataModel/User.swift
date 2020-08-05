
// Model class represents user data
//struct User: Codable {
//  let userID: String
//  let blogID: String
//  let createdDate: String
//  let avatar: String
//  let firstName: String
//  let lastName: String
//  let city: String
//  let designation: String
//  let about: String
//
//  enum CodingKeys: String, CodingKey {
//    case avatar, city, designation, about
//    case userID = "id"
//    case blogID = "blogId"
//    case createdDate = "createdAt"
//    case firstName = "name"
//    case lastName = "lastname"
//  }
//}

// MARK: - User
struct User: Codable {
    let id, blogID, createdAt, name: String
    let avatar: String
    let lastname, city, designation, about: String

    enum CodingKeys: String, CodingKey {
        case id
        case blogID = "blogId"
        case createdAt, name, avatar, lastname, city, designation, about
    }
}
