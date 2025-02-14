import Foundation

protocol NetworkViewModelProtocol {
  func loadData() async
  func refreshData() async
  
  var state: ListViewState { get }
}

protocol RecipesViewModelProtocol: ObservableObject, NetworkViewModelProtocol {
  var cuisines: [String] { get }
  func getRecipes(_ cuisineIndex: Int) -> [RecipeDTO]
}

final class RecipesViewModel: RecipesViewModelProtocol {
  
  private let repository: BaseRepositoryProtocol
  private var recipesMap: [String: [RecipeDTO]] = [:]
  
  @Published
  private(set) var state: ListViewState = .idle
  
  @Published
  private(set) var cuisines: [String] = []
  
  init(repository: BaseRepositoryProtocol = BaseRepository()) {
    self.repository = repository
  }
  
  @MainActor
  func loadData() async {
    if state == .loading { return }
    state = .loading
    do {
      try await Task.sleep(nanoseconds: 1_000_000_000)
      let baseDTOModel = try await repository.fetchBaseModel()
      state = .loaded
      processRecipes(baseDTOModel.recipes)
    } catch let err {
      state = .error(err)
    }
  }
  
  func refreshData() async {
    await loadData()
  }
  
  func getRecipes(_ cuisineIndex: Int) -> [RecipeDTO] {
    if cuisineIndex < 0 || cuisines.count <= cuisineIndex { return [] }
    let countryName = cuisines[cuisineIndex]
    return recipesMap[countryName, default: []]
  }
  
  private func processRecipes(_ recipes: [RecipeDTO]) {
    if recipes.isEmpty {
    state = .error(NetworkError.missingURL)
      return
    }
    
    var recipesMap: [String: [RecipeDTO]] = [:]
    for recipe in recipes {
      recipesMap[recipe.cuisine, default: []].append(recipe)
    }
    
    self.recipesMap = recipesMap
    cuisines = Array(recipesMap.keys.sorted())
  }
}
