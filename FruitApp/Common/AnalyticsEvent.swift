import Foundation

typealias SendEvent = ((AnalyticsEvent) -> Void)

enum AnalyticsEventType: String {
    case load
    case display
    case error
}

struct AnalyticsEvent: Encodable {
    
    // MARK: - Properties
    let category: String
    let data: String
    
    // MARK: - Lifecycle
    init(category: AnalyticsEventType, data: String) {
        self.category = category.rawValue
        self.data = data
    }
}
