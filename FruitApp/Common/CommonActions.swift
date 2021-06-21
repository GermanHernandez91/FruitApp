import Foundation

struct CommonActions {
    
    // MARK: - Properties
    let displayLoader: DisplayLoader
    let sendEvent: SendEvent
    let displayError: DisplayError
    
    // MARK: - Lifecycle
    init(displayLoader: @escaping DisplayLoader,
         sendEvent: @escaping SendEvent,
         displayError: @escaping DisplayError) {
        
        self.displayLoader = displayLoader
        self.displayError = displayError
        self.sendEvent = sendEvent
    }
}
