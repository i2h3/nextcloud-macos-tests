import Foundation

enum ClientValidationError: Error, LocalizedError {
    case notFound(path: String)
    case missingVersion
    case unsupportedVersion(found: String, minimum: String)

    var errorDescription: String? {
        switch self {
        case .notFound(let path):
            return "No Nextcloud app bundle found at \(path)."
        case .missingVersion:
            return "Could not read CFBundleShortVersionString from the Nextcloud app bundle."
        case .unsupportedVersion(let found, let minimum):
            return "Nextcloud app bundle version \(found) is below the required minimum of \(minimum)."
        }
    }
}
