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
    
    func generateViewModel(beginRefresh: (@escaping (@escaping RefreshCompleted) -> Void) = { _ in }) -> FruitsListViewModelProtocol {
        return FruitsListViewModel(data: mockFruitsDto, beginFrefresh: beginRefresh)
    }
}

private let mockFruitsDto = FruitsDto(response: mockFruitsResponse)
private let mockFruitsResponse = FruitsResponse(fruit: [])
