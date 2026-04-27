import Foundation
import os
import XCTest

///
/// Common base class for all tests in this project.
///
class TestCase: XCTestCase {
    let finder = XCUIApplication(bundleIdentifier: "com.apple.finder")
    let fileManager = FileManager.default
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "TestCase")

    // MARK: Credentials

    var password: String? {
        ProcessInfo.processInfo.environment["NEXTCLOUD_TESTS_PASSWORD"]
    }

    var server: String? {
        ProcessInfo.processInfo.environment["NEXTCLOUD_TESTS_SERVER"]
    }

    var user: String? {
        ProcessInfo.processInfo.environment["NEXTCLOUD_TESTS_USER"]
    }

    // MARK: Lifecycle

    override func setUp() async throws {
        try await super.setUp()
        try assertClientIsNotRunning()
        try validateClient()
        try clean()
    }

    ///
    /// A helper to let a calling test implementation fail with a message that it is not implemented yet.
    ///
    func reportMissingImplementation(file: StaticString = #filePath, line: UInt = #line) {
        XCTFail("This test is not implemented yet.", file: file, line: line)
    }
}
