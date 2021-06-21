import Foundation

struct FruitsDto: Equatable {
    let fruits: [FruitItemDto]
    
    init(response: FruitsResponse) {
        self.fruits = response.fruit.map { .init(response: $0) }
    }
}

struct FruitItemDto: Equatable {
    let type: String
    let price, weight: Double
    
    init(response: FruitItemResponse) {
        self.type = response.type
        self.price = (Double(response.price) / 100) // Convert into pounds from pence
        self.weight = (Double(response.weight) / 1000) // Convert into kg from grams
    }
}
