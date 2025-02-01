import SwiftUI

struct MainView<ViewModel: BaseViewModelProtocol>: View {
  
  @StateObject
  private var viewModel: ViewModel
  
  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel())
  }
  
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
  let vm = BaseViewModel()
  MainView(viewModel: vm)
}
