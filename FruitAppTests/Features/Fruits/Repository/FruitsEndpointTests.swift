import XCTest
@testable import FruitApp

final class FruitsEndpointTests: XCTestCase {
    
    /**
        Scenario 1
        Check that fetchAppetizers returns the correct url
     */
    func test_scenario1() {
        let endpoint = FruitsEndpoint.fetchFruits
        let url = endpoint.url()
        XCTAssertEqual(url.absoluteString, Constants.BASE_URL + "/data.json")
    }
}
