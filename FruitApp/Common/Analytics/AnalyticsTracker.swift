import Foundation

final class AnalyticsTracker: NSObject {
    
    static func trackEvent(with event: AnalyticsEvent, apiClient: APIClient) {
        let url = AnalyticsEndpoint.trackEvent(event: event).url()
        let request = AnalyticsRequest(url: url, httpMethod: .GET)
        
        apiClient.sendAnalyticEvent(request: request)
    }
}

extension AnalyticsTracker {
    
    static func sendEvent(_ event: AnalyticsEvent, networkSession: NetworkSession) {
        let apiClient = APIClient(networkSession: networkSession)
        AnalyticsTracker.trackEvent(with: event, apiClient: apiClient)
    }
}
