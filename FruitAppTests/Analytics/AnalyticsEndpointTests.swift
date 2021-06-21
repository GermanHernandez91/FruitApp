import XCTest
@testable import FruitApp

final class AnalyticsEndpointTests: XCTestCase {
    
    /**
        Scenario 1
        Check that fetchAppetizers returns the correct url
     */
    func test_scenario1() {
        let endpoint = AnalyticsEndpoint.trackEvent(event: mockAnalyticEvent)
        let url = endpoint.url()
        XCTAssertEqual(url.absoluteString, Constants.BASE_URL + "/stats?event=error&data=Something%20went%20wrong")
    }
}

private let mockAnalyticEvent = AnalyticsEvent(category: .error, data: "Something went wrong")
