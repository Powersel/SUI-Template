import SwiftUI

enum AppPages {
  case details
}

protocol AppCoordinator: ObservableObject {
  var path: NavigationPath { get set }
  
  func push(page: AppPages)
  func pop()
  func popToRoot()
}

final class MainCoordinator: AppCoordinator {
  @Published var path: NavigationPath = NavigationPath()
  
  func push(page: AppPages) {
    path.append(page)
  }
  
  func pop() {
    path.removeLast()
  }
  
  func popToRoot() {
    path.removeLast(path.count)
  }
}
