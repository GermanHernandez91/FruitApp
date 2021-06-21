import UIKit

private enum Screen {
    case fruits
}

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    private var childCoordinator: Coordinator?
    private let dependencies: Dependencies
    var rootViewController: UIViewController?
    
    // MARK: - Lifecycle
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Methods
    func start() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.goTo(.fruits)
            self.dependencies.window.rootViewController = self.rootViewController
            self.dependencies.window.makeKeyAndVisible()
        }
    }
    
    func reset() {
        childCoordinator = nil
    }
}

// MARK: - Data structures
extension AppCoordinator {
    
    struct Dependencies {
        let window: UIWindow
    }
}

// MARK: - Private implementation
private extension AppCoordinator {
    
    func goTo(_ screen: Screen) {
        
        switch screen {
        case .fruits:
            
            let navController = UINavigationController()
            rootViewController = navController
            
            let fruitsDependencies = FruitsCoordinator.Dependencies(navController: navController)
            childCoordinator = FruitsCoordinator(dependencies: fruitsDependencies)
            childCoordinator?.start()
        }
    }
}
