import Foundation

struct BaseDTOModel: Codable {
  let recipes: [RecipeDTO]
}

struct RecipeDTO: Codable, Identifiable {
  let cuisine: String
  let name: String
  let photoURL: String?
  let previewPhotoURL: String?
  let id: String
  let sourceURL: String?
  let videoURL: String?
  
  enum CodingKeys: String, CodingKey {
    case cuisine
    case name
    case photoURL = "photo_url_large"
    case previewPhotoURL = "photo_url_small"
    case id = "uuid"
    case sourceURL = "source_url"
    case videoURL = "youtube_url"
  }
}
