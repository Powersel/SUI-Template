import SwiftUI

@main
struct SUI_TemplateApp: App {
  
  let vm = BaseViewModel()
  
    var body: some Scene {
        WindowGroup {
          BaseView(viewModel: vm)
        }
    }
}
