import Foundation

struct FruitsDto: Equatable {
    let fruits: [FruitItemDto]
    
    init(response: FruitsResponse) {
        self.fruits = response.fruit.map { .init(response: $0) }
    }
}

struct FruitItemDto: Equatable {
    let type: String
    let price, weight: Int
    
    init(response: FruitItemResponse) {
        self.type = response.type
        self.price = response.price
        self.weight = response.weight
    }
}
