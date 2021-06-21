import Foundation

struct CommonActions {
    let displayLoader: DisplayLoader
    let sendEvent: SendEvent
    let displayError: DisplayError
    
    init(displayLoader: @escaping DisplayLoader,
         sendEvent: @escaping SendEvent,
         displayError: @escaping DisplayError) {
        
        self.displayLoader = displayLoader
        self.displayError = displayError
        self.sendEvent = sendEvent
    }
}
