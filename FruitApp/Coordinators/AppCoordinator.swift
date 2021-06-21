import UIKit

private enum Screen {
    case loader(Loader)
    case displayError(ErrorMessage)
    case fruits
}

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    private var childCoordinator: Coordinator?
    private let dependencies: Dependencies
    private var actions: Actions
    private var errorCoordinator: Coordinator?
    var rootViewController: UIViewController?
    
    private lazy var overlayCoordinator = OverlayCoordinator()
    private lazy var apiClient = APIClient(networkSession: dependencies.networkSession)
    lazy var commonActions: CommonActions = {
        return CommonActions(displayLoader: { [weak self] in self?.goTo(.loader($0)) },
                             sendEvent: actions.sendEvent,
                             displayError: { [weak self] in self?.goTo(.displayError($0)) })
    }()
    
    // MARK: - Lifecycle
    init(dependencies: Dependencies, actions: Actions) {
        self.dependencies = dependencies
        self.actions = actions
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
    
    struct Actions {
        let sendEvent: SendEvent
    }
    
    struct Dependencies {
        let window: UIWindow
        let networkSession: NetworkSession
    }
}

// MARK: - Private implementation
private extension AppCoordinator {
    
    func goTo(_ screen: Screen) {
        
        switch screen {
        case let .loader(loader):
            overlayCoordinator.launch(.loading(loader), rootViewController: rootViewController)
        
        case let .displayError(errorMessage):
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                guard let navigationController = self.activeNavigationController else {
                    let errorMessage = "Unable to retrive navigation controller"
                    assertionFailure(errorMessage)
                    self.actions.sendEvent(.init(category: .error, data: errorMessage))
                    return
                }
                
                let errorDependencies = ErrorHandlingCoordinator.Dependencies(navController: navigationController,
                                                                              errorMessage: errorMessage)
                
                let dismissError: () -> Void = { [weak self] in
                    self?.dismissErrorView(screenType: errorMessage.screenType)
                }
                
                let errorActions = ErrorHandlingCoordinator.Actions(dismissErrorView: dismissError,
                                                                    common: self.commonActions)
                
                self.errorCoordinator = ErrorHandlingCoordinator(dependencies: errorDependencies, actions: errorActions)
                self.errorCoordinator?.start()
            }
        
        case .fruits:
            
            let navController = UINavigationController()
            let remoteDataSource = FruitsRemoteDataSource(apiClient: apiClient)
            let repository = FruitsRepo(remoteDataSource: remoteDataSource)
            
            let fruitsDependencies = FruitsCoordinator.Dependencies(navController: navController, repository: repository)
            let fruitsActions = FruitsCoordinator.Actions(displayLoader: commonActions.displayLoader,
                                                          dispalyError: commonActions.displayError,
                                                          sendEvent: commonActions.sendEvent)
            
            rootViewController = navController
            childCoordinator = FruitsCoordinator(dependencies: fruitsDependencies, actions: fruitsActions)
            childCoordinator?.start()
        }
    }
    
    func dismissErrorView(screenType: ErrorScreenType) {
        
        switch screenType {
        case .fullScreen:
            activeNavigationController?.popToRootViewController(animated: false)
        case .modal:
            activeNavigationController?.dismiss(animated: true)
        case .alert:
            break
        }
        
        errorCoordinator = nil
    }
    
    var activeNavigationController: UINavigationController? {
        return rootViewController as? UINavigationController
    }
}
