import Foundation

struct LoadingViewModel: LoadingViewModelProtocol {
    
    // MARK: - Properties
    let transparentStyle: Bool
    let loadingMessage: [String]
    
    // MARK: - Lifecycle
    init(transparentStyle: Bool, loadingMessage: [String]) {
        self.transparentStyle = transparentStyle
        self.loadingMessage = loadingMessage
    }
}
