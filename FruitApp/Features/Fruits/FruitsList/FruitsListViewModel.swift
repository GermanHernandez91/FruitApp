import Foundation

struct FruitsListViewModel: FruitsListViewModelProtocol {
    
    // MARK: - Properties
    var title: String = .screenTitle
}

fileprivate extension String {
    static let screenTitle = "Fruits"
}
