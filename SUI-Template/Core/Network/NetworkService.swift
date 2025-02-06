import Foundation

enum NetworkError: Error {
  case missingURL
  case invalidURLComponents
  case invalidStatusCode(Int)
  
  /// Localizations for each error.
  var localizedDescription: String {
    switch self {
    case .invalidURLComponents:
      return "Invalid URL components"
    case .missingURL:
      return "Missing URL."
    case .invalidStatusCode(let statusCode):
      return "Request was not successfull. Finished with: \(statusCode) code."
    }
  }
}

protocol NetworkServiceProtocol {
  // Simple "GET" request, without extra parameters
  func fetchData(_ urlString: String) async throws -> Data
  
  // "GET" request, with extra parameters
  func fetchData(_ url: String, parameters: [String: String]) async throws -> Data
  
  // "POST" request, with extra parameters
  func postData(_ url: String, parameters: [String: String]) async throws -> Data
}

final class NetworkService {
  private let urlSession: URLSession
  private let defaultSessionInterval: TimeInterval = 15
  
  init() {
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForRequest = defaultSessionInterval
    
    self.urlSession = URLSession(configuration: sessionConfig)
  }
  
  private func constructURL(_ urlStr: String, _ parameters: [String: String] = [:]) throws -> URL {
    guard var components = URLComponents(string: urlStr) else {
      throw NetworkError.missingURL
    }
    
    components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    
    guard let url = components.url else {
      throw NetworkError.invalidURLComponents
    }
    
    return url
  }
  
  private func processRequest(_ request: URLRequest) async throws -> Data {
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
      throw NetworkError.invalidStatusCode((response as? HTTPURLResponse)?.statusCode ?? -1)
    }
    
    return data
  }
}

extension NetworkService: NetworkServiceProtocol {
  
  func fetchData(_ urlStr: String, parameters: [String: String]) async throws -> Data {
    do {
      let url = try constructURL(urlStr, parameters)
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "GET"
      let data = try await processRequest(urlRequest)
      
//      print(String(data: data, encoding: .utf8)!)
      
      return data
    } catch let err {
      throw NetworkError.invalidStatusCode(400)
    }
  }
  
  func postData(_ urlStr: String, parameters: [String : String]) async throws -> Data {
    do {
      let url = try constructURL(urlStr, parameters)
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "POST"
      let data = try await processRequest(urlRequest)
      
//      print(String(data: data, encoding: .utf8)!)
      
      return data
    } catch let err {
      throw NetworkError.invalidStatusCode(400)
    }
  }
  
  func fetchData(_ urlString: String) async throws -> Data {
    guard let url = URL(string: urlString) else { throw NetworkError.missingURL }
    
    let (data, responce) = try await urlSession.data(from: url)
    
    guard let httpResponce = responce as? HTTPURLResponse,
          httpResponce.statusCode == 200 else {
      throw NetworkError.invalidStatusCode(400)
    }
    
//    print(String(data: data, encoding: .utf8)!)
    
    return data
  }
}
