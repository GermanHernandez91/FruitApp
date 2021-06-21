import Foundation

struct NetworkSession {
    
    // MARK - Properties
    let session: URLSession
    
    // MARKL - Lifecycle
    init(session: URLSession) {
        self.session = session
    }
}

extension NetworkSession {
    
    static func defaultSession() -> NetworkSession {
        let session = URLSession(configuration: .default)
        return NetworkSession(session: session)
    }
}
