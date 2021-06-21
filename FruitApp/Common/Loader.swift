import Foundation

typealias DisplayLoader = (Loader) -> Void

struct Loader {
    
    // MARK: - Properties
    let show: Bool
    let transparent: Bool
    let messages: [String]
    
    // MARK: - Lifecycle
    init(show: Bool, transparent: Bool = false, messages: [String] = []) {
        self.show = show
        self.transparent = transparent
        self.messages = messages
    }
}
