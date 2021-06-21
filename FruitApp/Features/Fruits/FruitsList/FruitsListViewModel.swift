import Foundation

typealias RefreshCompleted = (_ data: FruitsDto?) -> Void

final class FruitsListViewModel: FruitsListViewModelProtocol {
 
    // MARK: - Properties
    var title: String = .screenTitle
    var fruits: [FruitItemDto] = []
    
    var beginRefresh: (@escaping RefreshCompleted) -> Void
    
    // MARK: - Lifecycle
    init(data: FruitsDto, beginFrefresh: @escaping (@escaping RefreshCompleted) -> Void) {
        self.fruits = data.fruits
        self.beginRefresh = beginFrefresh
    }
    
    // MARK: - Methods
    func refresh(completion: @escaping () -> Void) {
        beginRefresh { [weak self] data in
            self?.fruits = data?.fruits ?? []
            completion()
        }
    }
}

fileprivate extension String {
    static let screenTitle = "Fruits"
}
