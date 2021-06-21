import UIKit

private enum Screen {
    case fruitsList
}

final class FruitsCoordinator: Coordinator {
    
    // MARK: - Properties
    private var childCoordinator: Coordinator?
    private let dependencies: Dependencies
    
    // MARK: - Lifecycle
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Methods
    func start() {
        goTo(.fruitsList)
    }
}

// MARK: - Data structures
extension FruitsCoordinator {
    
    struct Dependencies {
        let navController: UINavigationController
    }
}

// MARK: - Private implementation
private extension FruitsCoordinator {
    
    func goTo(_ screen: Screen) {
        
        switch screen {
        case .fruitsList:
            
            let viewController = FruitsListViewController()
            
            viewController.viewModelFactory = {
                FruitsListViewModel()
            }
            
            dependencies.navController.setViewControllers([viewController], animated: false)
        }
    }
}
