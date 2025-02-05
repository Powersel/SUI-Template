import Foundation

enum DTOParsingError: Error {
  case parsingFailed
  
  var localizedDescription: String {
    switch self {
    case .parsingFailed: return "Model parsing error."
    }
  }
}

protocol DTOParsingServiceProtocol {
  func parseData<T>(_ data: Data, _ model: T.Type) throws -> T where T : Codable
}

final class DTOParsingService {
  private let decoder: JSONDecoder
  
  init() {
    let decoder = JSONDecoder()
    self.decoder = decoder
  }
}

extension DTOParsingService: DTOParsingServiceProtocol {
  func parseData<T>(_ data: Data, _ model: T.Type) throws -> T where T : Codable {
    do {
      let model = try decoder.decode(T.self, from: data)
      return model
    } catch {
      throw DTOParsingError.parsingFailed
    }
  }
}
