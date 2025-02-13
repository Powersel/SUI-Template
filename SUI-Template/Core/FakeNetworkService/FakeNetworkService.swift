import Foundation

enum FakeNetworkError: Error {
  case corruptedFile
  
  /// Localizations for each error.
  var localizedDescription: String {
    switch self {
    case .corruptedFile:
      return "Local file has bin corrupted URL components"
    }
  }
}

protocol FakeNetworkServiceProtocol {
  func getLocalFileData() async throws -> Data
}

final class FakeNetworkService: FakeNetworkServiceProtocol {
  private static let queue = DispatchQueue(label: "com.fake-network-session.queue", qos: .background)
  
  func getLocalFileData() async throws -> Data {
    do {
      let path = Bundle.main.path(forResource: "", ofType: "")!
      let localFileURL = URL(fileURLWithPath: path)
      try? await Task.sleep(nanoseconds: UInt64(1 * 1_000_000_000))
      let data = try Data(contentsOf: localFileURL)
      return data
    } catch {
      throw FakeNetworkError.corruptedFile
    }
  }
}
