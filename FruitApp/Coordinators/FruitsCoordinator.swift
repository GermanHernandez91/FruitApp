import UIKit

private enum Screen {
    case fetchFruits
    case refreshFruits(completion: RefreshCompleted)
    case fruitsList(FruitsDto)
    case fruitDetails(FruitItemDto)
}

final class FruitsCoordinator: Coordinator {
    
    // MARK: - Properties
    private var childCoordinator: Coordinator?
    private let dependencies: Dependencies
    private let actions: Actions
    private var startLoadingScreen: Date
    
    // MARK: - Lifecycle
    init(dependencies: Dependencies, actions: Actions) {
        self.dependencies = dependencies
        self.actions = actions
        self.startLoadingScreen = Date()
    }
    
    // MARK: - Methods
    func start() {
        goTo(.fetchFruits)
    }
}

// MARK: - Data structures
extension FruitsCoordinator {
    
    struct Actions {
        let displayLoader: DisplayLoader
        let dispalyError: DisplayError
        let sendEvent: SendEvent
    }
    
    struct Dependencies {
        let navController: UINavigationController
        let repository: FruitsRepository
    }
}

// MARK: - Private implementation
private extension FruitsCoordinator {
    
    func goTo(_ screen: Screen) {
        
        switch screen {
        case .fetchFruits:
            
            let startDate = Date()
            
            dependencies.repository.fetchFruits { [weak self] result in
                guard let self = self else { return }
            
                let finishDate = Date()
                let executionTime = finishDate.timeIntervalSince(startDate)
                print("Execution time fetching data: \(executionTime)")
                self.actions.sendEvent(.init(category: .load, data: "\(executionTime)"))
                
                switch result {
                case .success(let fruits):
                    self.goTo(.fruitsList(fruits))
                    
                case .failure(let error):
                    self.actions.dispalyError(.somethingWentWrong())
                    self.actions.sendEvent(.init(category: .error, data: error.localizedDescription))
                }
            }
            
        case let .refreshFruits(completion):

            let startDate = Date()
            
            dependencies.repository.fetchFruits { [weak self] result in
                guard let self = self else { return }
                
                let finishDate = Date()
                let executionTime = finishDate.timeIntervalSince(startDate)
                print("Execution time refreshing data: \(executionTime)")
                self.actions.sendEvent(.init(category: .load, data: "\(executionTime)"))
                
                switch result {
                case .success(let fruits):
                    completion(fruits)
                    
                case .failure(let error):
                    completion(nil)
                    self.actions.sendEvent(.init(category: .error, data: error.localizedDescription))
                }
            }
        
        case let .fruitsList(fruits):
            
            let viewController = FruitsListViewController()
            
            viewController.viewModelFactory = {
                FruitsListViewModel(data: fruits,
                                    beginFrefresh: { [weak self] completion in self?.goTo(.refreshFruits(completion: completion)) })
            }
            
            viewController.delegate = self
            
            dependencies.navController.setViewControllers([viewController], animated: false)
            
        case let .fruitDetails(fruitItem):
            
            let viewController = FruitDetailsViewController()
            
            viewController.viewModelFactory = {
                FruitDetailsViewModel(fruit: fruitItem)
            }
            
            dependencies.navController.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - FruitsDelegate
extension FruitsCoordinator: FruitsListViewModelDelegate {
    
    func didTapCell(with fruit: FruitItemDto) {
        goTo(.fruitDetails(fruit))
    }
    
    func didFinishLoading(with date: Date) {
        let executionTime = date.timeIntervalSince(startLoadingScreen)
        print("Execution time loading screen: \(executionTime)")
        actions.sendEvent(.init(category: .display, data: "\(executionTime)"))
    }
}
