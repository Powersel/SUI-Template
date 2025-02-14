import Foundation

enum APIEndpoint {
  private var baseURL: String { return "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json" }
  static let apiKey: String = ""
  
  case base
}

extension APIEndpoint {
  var path: String {
    switch self {
      case .base: return baseURL
    }
  }
}

// Rick & Morty default endpoints
//extension APIEndpoint {
//  var path: String {
//    switch self {
//    case .characters: return baseURL + "/character"
//    case .locations: return baseURL + "/location"
//    case .episodes: return baseURL + "/episode"
//    }
//  }
//}
