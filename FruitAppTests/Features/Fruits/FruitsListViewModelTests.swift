import XCTest
@testable import FruitApp

final class FruitsListViewModelTest: XCTestCase {
    
    /**
        Scenario 1:
        Successfully passed in screen title
     */
    func test_scenario1() {
        let sut = generateViewModel()
        XCTAssertEqual(sut.title, "Fruits")
    }
    
    /**
        Scenario 2:
        Successfully fruits data passed in
     */
    func test_scenario2() {
        let sut = generateViewModel()
        XCTAssertEqual(sut.fruits, mockFruitsDto.fruits)
    }
}

private extension FruitsListViewModelTest {
    
    func generateViewModel() -> FruitsListViewModelProtocol {
        return FruitsListViewModel(data: mockFruitsDto)
    }
}

private let mockFruitsDto = FruitsDto(response: mockFruitsResponse)
private let mockFruitsResponse = FruitsResponse(fruit: [])
