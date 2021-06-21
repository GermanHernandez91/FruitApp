import Foundation

struct FruitDetailsViewModel: FruitDetailsViewModelProtocol {
    
    // MARK: - Properties
    var title: String
    var fruit: FruitItemDto
    
    // MARK: - Lifecycle
    init(fruit: FruitItemDto) {
        self.fruit = fruit
        self.title = fruit.type
    }
}
