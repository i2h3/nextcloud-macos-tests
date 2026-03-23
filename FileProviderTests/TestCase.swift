import Foundation
import os
import XCTest

///
/// Common base class for all tests in this project.
///
class TestCase: XCTestCase {
    private let fileManager = FileManager.default
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Environment")

    ///
    /// Remove any files and folders the subject under test uses or creates.
    ///
    func clean() throws {
        logger.debug("Cleaning up the test environment…")

        let paths = [
            "~/Library/Containers/com.nextcloud.desktopclient",
            "~/Library/Group Containers/NKUJUXUJ3B.com.nextcloud.desktopclient"
        ]

        for path in paths {
            // Expand tilde and create standardized, absolute URL
            let expandedPath = NSString(string: path).expandingTildeInPath
            let url = URL(fileURLWithPath: expandedPath).standardized
            
            // Check if the item exists
            if fileManager.fileExists(atPath: url.path) {
                try fileManager.removeItem(at: url)
                logger.debug("Deleted: \(url.path)")
            } else {
                logger.debug("Item to delete does not exist: \(url.path)")
            }
        }

        logger.debug("Cleanup completed.")
    }

    func reportMissingImplementation(file: StaticString = #filePath, line: UInt = #line) {
        XCTFail("This test is not implemented yet.", file: file, line: line)
    }
}
