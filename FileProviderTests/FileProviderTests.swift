import Foundation
import XCTest

final class FileProviderTests: TestCase {
    override func setUp() async throws {
        try await super.setUp()
        try clean()
    }

    // MARK: - Essentials

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

    // MARK: - Local Changes

    ///
    /// Verify the server-side appearance of a locally created item.
    ///
    func testLocalCreation() {
        reportMissingImplementation()
    }

    ///
    /// Verify the server-side metadata update of a locally modified item.
    ///
    func testLocalMetadataUpdate() {
        reportMissingImplementation()
    }

    ///
    /// Verify the server-side content update of a locally modified item.
    ///
    func testLocalContentUpdate() {
        reportMissingImplementation()
    }

    ///
    /// Verify the server-side deletion of a locally deleted item.
    ///
    func testLocalDeletion() {
        reportMissingImplementation()
    }

    ///
    /// Verify the remote state for a locally moved item.
    ///
    func testLocalMove() {
        reportMissingImplementation()
    }

    // MARK: - Remote Changes

    ///
    /// Enumerate a new item created on the server.
    ///
    func testRemoteCreation() {
        reportMissingImplementation()
    }

    ///
    /// Update the local metadata of a dataless item after it has been modified on the server.
    ///
    func testRemoteUpdate() {
        reportMissingImplementation()
    }

    ///
    /// Verify the disappearance of an already enumerated item which has been deleted on the server.
    ///
    func testRemoteDeletion() {
        reportMissingImplementation()
    }

    ///
    /// Verify the local state after a remote item move.
    ///
    func testRemoteMove() {
        reportMissingImplementation()
    }

    // MARK: - Transfers

    ///
    /// Download a file and compare its content with the state on the server.
    ///
    func testDownload() {
        reportMissingImplementation()
    }

    ///
    /// Update the local content of a materialized item after it has been modified on the server.
    ///
    func testDownloadAfterRemoteUpdate() {
        reportMissingImplementation()
    }

    ///
    /// Test the upload of a materialized item.
    ///
    func testUpload() {
        reportMissingImplementation()
    }

    // MARK: - Trash

    ///
    /// Test the local item deletion with a trash-enabled server.
    ///
    func testLocalDeletionWithTrashSupport() {
        reportMissingImplementation()
    }

    ///
    /// Test the local item deletion with a trash-disabled server.
    ///
    func testLocalDeletionWithoutTrashSupport() {
        reportMissingImplementation()
    }

    ///
    /// Test the remote item deletion with a trash-enabled server.
    ///
    func testRemoteDeletionWithTrashSupport() {
        reportMissingImplementation()
    }

    ///
    /// Test the remote item deletion with a trash-disabled server.
    ///
    func testRemoteDeletionWithoutTrashSupport() {
        reportMissingImplementation()
    }
}
