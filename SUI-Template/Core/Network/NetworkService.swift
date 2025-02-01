import Foundation

enum NetworkError: Error {
  case missingURL
  case invalidStatusCode(Int)
  
  /// Localizations for each error.
  var localizedDescription: String {
    switch self {
    case .missingURL:
      return "Missing URL."
    case .invalidStatusCode(let statusCode):
      return "Request was not successfull. Finished with: \(statusCode) code."
    }
  }
}

protocol NetworkServiceProtocol {
  func fetchData(_ url: String) async throws -> Data
}

final class NetworkService {
  private let urlSession: URLSession
  
  init() {
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForRequest = 10
    
    self.urlSession = URLSession(configuration: sessionConfig)
  }
}

extension NetworkService: NetworkServiceProtocol {
  func fetchData(_ urlString: String) async throws -> Data {
    guard let url = URL(string: urlString) else { throw NetworkError.missingURL }
    
    let (data, responce) = try await urlSession.data(from: url)
    
    guard let httpResponce = responce as? HTTPURLResponse,
          httpResponce.statusCode == 200 else {
      throw NetworkError.invalidStatusCode(400)
    }
    
    return data
  }
}
