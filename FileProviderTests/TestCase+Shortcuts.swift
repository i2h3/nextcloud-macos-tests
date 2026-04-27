import XCTest

///
/// Central implementation of common procedures in user interface tests.
///
extension TestCase {
    ///
    /// Assert the visibility of an item in the finder collection view with the given label.
    ///
    /// - Parameters:
    ///     - label: The name of the item expected to be visible.
    ///
    func assertItemVisibility(_ label: String, file: StaticString = #filePath, line: UInt = #line) {
        let table = finder.tables.firstMatch
        let item = table.staticTexts[label]
        XCTAssertTrue(item.exists, "Item \"\(label)\" should be visible in Finder", file: file, line: line)
    }

    ///
    /// Open the file provider domain in Finder.
    ///
    func revealFileProviderDomainInFinder(file: StaticString = #filePath, line: UInt = #line) {
        // Bring Finder to the foreground
        finder.launch()

        // Assert visibility of sidebar in Finder
        let sidebar = finder.windows.firstMatch.outlines.firstMatch
        XCTAssertTrue(sidebar.exists, "Finder sidebar should be visible", file: file, line: line)

        // Assert visibility of locations item
        let locations = sidebar.staticTexts["Locations"]
        XCTAssertTrue(locations.exists, "Locations section title should be visible", file: file, line: line)

        // Assert visibility of Nextcloud item
        let domain = sidebar.staticTexts["Nextcloud"]
        XCTAssertTrue(domain.exists, "Nextcloud should appear in sidebar", file: file, line: line)

        // Select file provider domain
        domain.click()

        // Select list view
        finder.typeKey("2", modifierFlags: .command)
    }
}
