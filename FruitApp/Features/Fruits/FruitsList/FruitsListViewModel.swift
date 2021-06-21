import Foundation

final class FruitsListViewModel: FruitsListViewModelProtocol {
   
    // MARK: - Properties
    var title: String = .screenTitle
    var fruits: [FruitItemDto] = []
    
    // MARK: - Lifecycle
    init(data: FruitsDto) {
        self.fruits = data.fruits
    }
}

fileprivate extension String {
    static let screenTitle = "Fruits"
}
