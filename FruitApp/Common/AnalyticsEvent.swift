import Foundation

typealias SendEvent = ((AnalyticsEvent) -> Void)

enum AnalyticsEventType: String {
    case load
    case display
    case error
}

struct AnalyticsEvent: Encodable {
    
    let category: String
    let data: String
    
    init(category: AnalyticsEventType, data: String) {
        self.category = category.rawValue
        self.data = data
    }
}
