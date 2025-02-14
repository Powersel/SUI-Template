import SwiftUI

@main
struct SUI_TemplateApp: App {
    var body: some Scene {
        WindowGroup {
          MainView(viewModel: RecipesViewModel(), MainCoordinator())
        }
    }
}
