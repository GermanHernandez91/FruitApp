import UIKit

protocol FruitDetailsViewModelProtocol {
    var title: String { get }
    var fruit: FruitItemDto { get }
}

final class FruitDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private let priceLabel = TitleLabel(textAlignment: .left, fontSize: 20)
    private let weightLabel = TitleLabel(textAlignment: .left, fontSize: 20)
    
    private var viewModel: FruitDetailsViewModelProtocol!
    
    var viewModelFactory: () -> FruitDetailsViewModelProtocol = {
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
private extension FruitDetailsViewController {
    
    func bind(viewModel: FruitDetailsViewModelProtocol) {
        self.viewModel = viewModel
        
        navigationItem.title = viewModel.title
        configurePriceLabel()
        configureWeightLabel()
    }
}

// MARK: - UI Components
private extension FruitDetailsViewController {
    
    func configurePriceLabel() {
        view.addSubview(priceLabel)
        
        priceLabel.text = "Price: £" + String(format: "%.2f", viewModel.fruit.price)
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureWeightLabel() {
        view.addSubview(weightLabel)
        
        weightLabel.text = "Weight: \(viewModel.fruit.weight) kg"
        
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            weightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            weightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
