import Foundation

enum ErrorScreenType {
    case fullScreen
    case modal
    case alert
}

extension ErrorMessage {
    
    static func noInternet(screenType: ErrorScreenType = .fullScreen) -> ErrorMessage {
        return .init(title: .noInternetTitle, actionTitle: .noInternetDesc, screenType: screenType)
    }
    
    static func somethingWentWrong(screenType: ErrorScreenType = .fullScreen) -> ErrorMessage {
        return .init(title: .somethingWentWrongTitle, actionTitle: .somethingWentWrongDesc, screenType: screenType)
    }
    
    static func noData(screenType: ErrorScreenType = .alert) -> ErrorMessage {
        return .init(title: .noDataTitle, description: .noDataDesc, actionTitle: "OK", screenType: screenType, alertAction: nil)
    }
}

fileprivate extension String {
    
    // No internet
    static let noInternetTitle = "Please check your internet connection"
    static let noInternetDesc = "We cannot connect to our servers. Please check your internet connection and try again"
    
    // Something went wrong
    static let somethingWentWrongTitle = "Oh no!\nSomething went wrong!"
    static let somethingWentWrongDesc = "Please try again later"
    
    // No Data
    static let noDataTitle = "Something went wrong fetching the data"
    static let noDataDesc = "We've encounter an issues fetching the data. Please try again later"
}
