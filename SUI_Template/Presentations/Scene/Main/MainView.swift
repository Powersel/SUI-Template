import SwiftUI

struct MainView<ViewModel: RecipesViewModelProtocol, AppCoord: AppCoordinator>: View {
  
  @StateObject
  private var viewModel: ViewModel
  
  @StateObject
  private var coordinator: AppCoord
  
  init(viewModel: @autoclosure @escaping () -> ViewModel, _ coordinator: @autoclosure @escaping () -> AppCoord) {
    _viewModel = StateObject(wrappedValue: viewModel())
    _coordinator = StateObject(wrappedValue: coordinator())
  }
  
  var body: some View {
    NavigationStack(path: $coordinator.path) {
      VStack {
        switch viewModel.state {
        case .loaded:
          CuisinesListView(viewModel: viewModel)
        case .error(_):
          ErrorView(viewModel: viewModel)
        case .idle, .loading:
          LoadingView()
        case .empty:
          RecipesEmptyView(viewModel: viewModel)
        }
      }
      .onAppear() {
        Task {
          await viewModel.loadData()
        }
      }
      .padding()
      .navigationTitle("Recipes")
    }
  }
}

#Preview {
  let vm = RecipesViewModel()
  let coord = MainCoordinator()
  MainView(viewModel: vm, coord)
}
