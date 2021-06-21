import UIKit

final class ErrorViewControllerFactory {
    
    // MARK: - Properties
    private let dependencies: Dependencies
    private let actions: Actions
    
    // MARK: - Lifecylce
    init(dependencies: Dependencies, actions: Actions) {
        self.dependencies = dependencies
        self.actions = actions
    }
}

extension ErrorViewControllerFactory {
    
    struct Actions {
        let sendEvent: SendEvent
    }
    
    struct Dependencies {
        let errorMessage: ErrorMessage
    }
}

extension ErrorViewControllerFactory {
    
    func makeFullScreen(using screen: ErrorHandlingCoordinator.Screen, action: @escaping () -> Void) -> ErrorHandlingViewController {
        
        let viewController = ErrorHandlingViewController()
        
        viewController.viewModelFactory = { [weak self] in
            ErrorHandlingViewModel(errorMessage: self?.dependencies.errorMessage, action: {})
        }
        
        return viewController
    }
    
    func makeModal(action: @escaping () -> Void) -> ErrorHandlingViewController {
        
        let viewController = ErrorHandlingViewController()
        
        viewController.viewModelFactory = { [weak self] in
            ErrorHandlingViewModel(errorMessage: self?.dependencies.errorMessage, action: action)
        }
        
        return viewController
    }
    
    func makeAlert(completeAction: @escaping () -> Void) -> UIAlertController {
        
        let errorMessage = dependencies.errorMessage
        
        let alert = UIAlertController(title: errorMessage.title,
                                      message: errorMessage.description,
                                      preferredStyle: .alert)
        
        for alertAction in errorMessage.actions {
            let action = UIAlertAction(title: alertAction.title, style: .default) { _ in
                alertAction.action()
                completeAction()
            }
            alert.addAction(action)
        }
        
        return alert
    }
}
