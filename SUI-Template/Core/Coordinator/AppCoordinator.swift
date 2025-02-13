import UIKit

protocol AppCoordinator {
  func start()
}

final class MainCoordinator: AppCoordinator {
  private let window: UIWindow
  private let navigationController: UINavigationController
  
  init(window: UIWindow) {
    self.window = window
    self.navigationController = UINavigationController()
  }
  
  func start() {
    
  }
}
