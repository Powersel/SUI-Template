import SwiftUI

struct BaseView<ViewModel: BaseViewModelProtocol>: View {
  
  @StateObject
  private var viewModel: ViewModel
  
  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel())
  }
  
    var body: some View {
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
    }
}

#Preview {
  let vm = BaseViewModel()
  BaseView(viewModel: vm)
}
