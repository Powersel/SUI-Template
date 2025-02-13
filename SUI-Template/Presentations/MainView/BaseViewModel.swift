import Foundation

protocol NetworkViewModelProtocol {
  func loadData() async
  var state: ListViewState { get }
}

protocol BaseViewModelProtocol: ObservableObject, NetworkViewModelProtocol {
  var item: BaseDTOModel { get }
}

final class BaseViewModel: BaseViewModelProtocol {
  
  private let repository: BaseRepositoryProtocol
  
  @Published
  private(set) var state: ListViewState = .idle
  
  @Published
  private(set) var item: BaseDTOModel
  
  init(repository: BaseRepositoryProtocol = BaseRepository()) {
    self.repository = repository
    self.item = BaseDTOModel()
  }
  
  @MainActor
  func loadData() async {
    if state == .loading { return }
    state = .loading
    do {
      let fetchedModel = try await repository.fetchBaseModel()
      state = .loaded
      item = fetchedModel
    } catch let err {
      state = .error(err)
    }
  }
}
