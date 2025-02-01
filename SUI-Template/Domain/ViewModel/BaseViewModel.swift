import Foundation

protocol NetworkViewModelProtocol {
  func loadData() async
  var state: ListViewState { get }
}

protocol BaseViewModelProtocol: ObservableObject, NetworkViewModelProtocol {
  
}

final class BaseViewModel: BaseViewModelProtocol {
  
  private let repository: BasicRepositoryProtocol
  
  @Published
  private(set) var state: ListViewState = .idle
  
  init(repository: BasicRepositoryProtocol = BasicRepository()) {
    self.repository = repository
  }
  
  func loadData() async {
    
  }
}
