import SwiftUI

struct MainView<ViewModel: BaseViewModelProtocol, AppCoord: AppCoordinator>: View {
  
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
            Text("Model been loaded!")
          case .error(let err):
            Text("Network issues")
          case .idle:
            Text("Model is in IDLE state")
          case .loading:
            Text("Work in progress, loading data")
          }
        }
        .task {
          await viewModel.loadData()
        }
        .padding()
        .navigationTitle("Main screen")
        .navigationDestination(for: AppPages.self) { scene in
          switch scene {
          default:
            Text("Details screen")
          }
        }
      }
      
    }
}

#Preview {
  let vm = BaseViewModel()
  let coord = MainCoordinator()
  MainView(viewModel: vm, coord)
}
