import Foundation

enum FruitsEndpoint: Endpoint {
    case fetchFruits
}

extension FruitsEndpoint {
    
    var stringValue: String {
        
        let endpoint = "/data.json"
        
        switch self {
        case .fetchFruits:
            return endpoint
        }
    }
}
