import Foundation

enum AnalyticsEndpoint: Endpoint {
    case trackEvent(event: AnalyticsEvent)
}

extension AnalyticsEndpoint {
    
    var stringValue: String {
        
        let endpoint = "/stats"
        
        switch self {
        case let.trackEvent(event):
            let data = event.data.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            return "\(endpoint)?event=\(event.category)&data=\(data)"
        }
    }
}
