import XCTest
@testable import FruitApp

final class FruitDetailsViewModelTest: XCTestCase {
    
    /**
        Scenario 1:
        Successfully passed in screen title
     */
    func test_scenario1() {
        let sut = generateViewModel()
        XCTAssertEqual(sut.title, "Apple")
    }
    
    /**
        Scenario 2:
        Successfully fruits data passed in
     */
    func test_scenario2() {
        let sut = generateViewModel()
        XCTAssertEqual(sut.fruit, mockFruitItemDto)
    }
    
    /**
        Scenario 3:
        Fruit price is displayed in Pounds
     */
    func test_scenario3() {
        let sut = generateViewModel()
        XCTAssertEqual(sut.fruit.price, 6.36)
    }
    
    /**
        Scenario 4:
        Fruit weight is displayed in Kg
     */
    func test_scenario4() {
        let sut = generateViewModel()
        XCTAssertEqual(sut.fruit.weight, 4.5)
    }
}

private extension FruitDetailsViewModelTest {
    
    func generateViewModel() -> FruitDetailsViewModelProtocol {
        return FruitDetailsViewModel(fruit: mockFruitItemDto)
    }
}

private let mockFruitItemDto = FruitItemDto(response: mockFruitItemResponse)
private let mockFruitItemResponse = FruitItemResponse(type: "Apple", price: 636, weight: 4500)
