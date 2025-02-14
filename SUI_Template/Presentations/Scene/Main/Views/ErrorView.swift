import SwiftUI

struct ErrorView<ViewModel: RecipesViewModelProtocol>: View {
  
  @StateObject
  private var viewModel: ViewModel
  
  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel())
  }
  
  var body: some View {
    VStack(spacing: 30) {
      Spacer(minLength: 20)
      HStack {
        Spacer(minLength: 20)
        Text("Network error occured. Try again later").font(.largeTitle)
        Spacer(minLength: 20)
      }
      Button("Reload data") {
        Task {
          await viewModel.refreshData()
        }
      }
      .font(.system(size: 30, weight: .bold, design: .default))
      Spacer(minLength: 20)
    }
  }
}

#Preview {
  let vm = RecipesViewModel()
  ErrorView(viewModel: vm)
}
