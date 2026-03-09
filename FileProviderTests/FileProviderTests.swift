import Foundation
import XCTest

final class FileProviderTests: XCTestCase {
    @MainActor
    func testDomainAppearance() throws {
        // At this time, the test assumes that the client was setup with a single account manually beforehand.

        // Bring Finder to the foreground
        let finder = XCUIApplication(bundleIdentifier: "com.apple.finder")
        finder.launch()

        // Assert visibility of sidebar in Finder
        let sidebar = finder.windows.firstMatch.outlines.firstMatch
        XCTAssertTrue(sidebar.exists, "Finder sidebar should be visible")

        // Assert visibility of locations item
        let locations = sidebar.staticTexts["Locations"]
        XCTAssertTrue(locations.exists, "Locations section title should be visible")

        // Assert visibility of Nextcloud item
        let domain = sidebar.staticTexts["Nextcloud"]
        XCTAssertTrue(domain.exists, "Nextcloud should appear in sidebar")

        // Select file provider domain
        domain.click()
    }
}
