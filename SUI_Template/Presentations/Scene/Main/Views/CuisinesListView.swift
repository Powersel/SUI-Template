import SwiftUI

struct CuisinesListView<ViewModel: RecipesViewModelProtocol>: View {
  
  @StateObject
  private var viewModel: ViewModel
  
  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel())
  }
  
    var body: some View {
      List {
        ForEach(0..<viewModel.cuisines.count, id: \.self) { index in
          CuisineViewSection(recipeDTOs: viewModel.getRecipes(index))
          }
        }
      .refreshable {
        Task {
          await viewModel.refreshData()
        }
      }
      .listStyle(.insetGrouped)
    }
}
