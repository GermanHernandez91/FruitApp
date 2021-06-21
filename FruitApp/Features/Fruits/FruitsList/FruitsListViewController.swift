import UIKit

protocol FruitsListViewModelProtocol {
    var title: String { get }
}

final class FruitsListViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: FruitsListViewModelProtocol!
    
    var viewModelFactory: () -> FruitsListViewModelProtocol = {
        fatalError("View model has not been created")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        
        bind(viewModel: viewModelFactory())
    }
}

// MARK: - Private implementation
private extension FruitsListViewController {
    
    func bind(viewModel: FruitsListViewModelProtocol) {
        self.viewModel = viewModel
        
        navigationItem.title = viewModel.title
    }
}
