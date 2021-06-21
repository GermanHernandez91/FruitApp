import UIKit

protocol FruitsListViewModelProtocol {
    var title: String { get }
    var fruits: [FruitItemDto] { get }
    
    func refresh(completion: @escaping () -> Void)
}

protocol FruitsListViewModelDelegate: AnyObject {
    func didTapCell(with fruit: FruitItemDto)
    func didFinishLoading(with date: Date)
}

final class FruitsListViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: FruitsListViewModelDelegate!
    private var viewModel: FruitsListViewModelProtocol!
    
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    var viewModelFactory: () -> FruitsListViewModelProtocol = {
        fatalError("View model has not been created")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        
        delegate.didFinishLoading(with: Date())
        bind(viewModel: viewModelFactory())
    }
}

// MARK: - Private implementation
private extension FruitsListViewController {
    
    func bind(viewModel: FruitsListViewModelProtocol) {
        self.viewModel = viewModel
        
        navigationItem.title = viewModel.title
        
        configureTableView()
        configureRefreshControl()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
        tableView.reloadData()
    }
    
    func configureRefreshControl() {
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.refresh() { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableView extension
extension FruitsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let fruit = viewModel.fruits[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = fruit.type
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fruit = viewModel.fruits[indexPath.row]
        delegate.didTapCell(with: fruit)
    }
}
