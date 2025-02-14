import Foundation

/// The state of the view.
enum ListViewState: Equatable {
  
  /// idle
  case idle
  
  /// Empty state
  case empty
  
  /// Loading is in progress.
  case loading
  
  /// Loaded already.
  case loaded
  
  /// Error
  case error(Error)
  
  // MARK: - Conformance: Equatable
  
  static func == (lhs: ListViewState, rhs: ListViewState) -> Bool {
    switch (lhs, rhs) {
    case (.idle, .idle),
      (.empty, .empty),
      (.loading, .loading),
      (.loaded, .loaded):
      return true
    case (.error(let lhsError), .error(let rhsError)):
      return lhsError.localizedDescription == rhsError.localizedDescription
    default:
      return false
    }
  }
}
