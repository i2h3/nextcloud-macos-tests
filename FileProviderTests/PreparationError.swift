import Foundation

enum PreparationError: Error, LocalizedError {
    case clientIsRunning

    var errorDescription: String? {
        switch self {
        case .clientIsRunning:
            return "The Nextcloud desktop client is already running. Quit it before starting the test suite."
        }
    }
}
