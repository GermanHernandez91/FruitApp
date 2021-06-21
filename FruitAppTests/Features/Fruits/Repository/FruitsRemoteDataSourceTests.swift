import XCTest
@testable import FruitApp

final class FruitsRemoteDataSourceTests: XCTestCase {
    
    // MARK: - Properties
    private var fruits: FruitsDto?
    private var fetchDataExpectation: XCTestExpectation!

    // MARK: - Lifecylce
    override func setUp() {
        super.setUp()
        
        fetchDataExpectation = expectation(description: "Fruits fetched")
    }
    
    override func tearDown() {
        
        fetchDataExpectation = nil
        
        super.tearDown()
    }
    
    /**
        Scenario 1
        Create the data source and fetch data
     */
    func test_scenario1() {
        let sut = generateSut()
        
        sut.fetchFruits { [weak self] result in
            guard let self = self else {  return }
            
            switch result {
            case .success(let data):
                self.fruits = data
                self.fetchDataExpectation.fulfill()
                
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
        
        waitForExpectations(timeout: 0.1) { [weak self] error in
            XCTAssertNotNil(self?.fruits)
        }
    }
}

private extension FruitsRemoteDataSourceTests {
    
    func generateSut() -> FruitsDataFetch {
        let apiClient = APIClient.mock(bundleId: bundleId)
        return FruitsRemoteDataSource(apiClient: apiClient)
    }
}

private let bundleId = "com.example.germanhernandez.FruitAppTests"
