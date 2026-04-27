import Foundation
import XCTest

final class DomainTests: TestCase {
    func testAppearance() throws {
        revealFileProviderDomainInFinder()
        assertItemVisibility("Nextcloud Manual.pdf")
    }
}
