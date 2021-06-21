import Foundation

struct FruitsResponse: Codable {
    let fruit: [FruitItemResponse]
}

struct FruitItemResponse: Codable {
    let type: String
    let price, weight: Int
}
