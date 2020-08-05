
// Model class represents Article data
struct Article: Codable {
  let id: String
  let createdAt: String
  let content: String
  let likes: Int
  let comments : Int
  let media: [Media]
  let user: [User]
}
