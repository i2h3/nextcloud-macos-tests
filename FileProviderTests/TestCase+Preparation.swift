import AppKit
import XCTest
import os

///
/// Implementations to set up tests.
///
extension TestCase {
    func assertClientIsNotRunning() throws {
        let running = NSRunningApplication.runningApplications(withBundleIdentifier: "com.nextcloud.desktopclient")

        guard running.isEmpty else {
            throw PreparationError.clientIsRunning
        }
    }

    ///
    /// Remove any files and folders the subject under test uses or creates.
    ///
    func clean() throws {
        logger.debug("Cleaning up the test environment…")

        let paths = [
            "~/Library/Caches/com.nextcloud.desktopclient",
            "~/Library/Caches/Nextcloud",
            "~/Library/Containers/com.nextcloud.desktopclient",
            "~/Library/Containers/com.nextcloud.desktopclient.FinderSyncExt",
            "~/Library/Containers/com.nextcloud.desktopclient.FileProviderExt",
            "~/Library/Containers/com.nextcloud.desktopclient.FileProviderUIExt",
            "~/Library/Group Containers/com.nextcloud.desktopclient",
            "~/Library/Group Containers/NKUJUXUJ3B.com.nextcloud.desktopclient",
            "~/Library/Preferences/Nextcloud",
            "~/Library/Preferences/com.nextcloud.desktopclient.plist"
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

    ///
    /// Set up the test account in the desktop client.
    ///
    func configureAccount() {
        let environment = ProcessInfo.processInfo.environment

        guard let serverURL = environment["NC_SERVER_URL"], let username = environment["NC_USERNAME"], let password = environment["NC_PASSWORD"] else {
            XCTFail("Missing required environment variables: NC_SERVER_URL, NC_USERNAME, NC_PASSWORD")
            return
        }

        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/Applications/Nextcloud.app/Contents/MacOS/nextcloudcmd")
        process.arguments = ["--silent", "--user", username, "--password", password, ".", serverURL]

        do {
            try process.run()
            process.waitUntilExit()
        } catch {
            XCTFail("Failed to run the Nextcloud client CLI to configure an account: \(error.localizedDescription)")
        }
    }

    ///
    /// Check for the app bundle to test to fulfill certain requirements.
    ///
    func validateClient() throws {
        let bundlePath = "/Applications/Nextcloud.app"
        let minimumVersion = "33.0.0"

        guard fileManager.fileExists(atPath: bundlePath),
              let bundle = Bundle(path: bundlePath) else {
            throw ClientValidationError.notFound(path: bundlePath)
        }

        guard let version = bundle.infoDictionary?["CFBundleShortVersionString"] as? String else {
            throw ClientValidationError.missingVersion
        }

        if version.compare(minimumVersion, options: .numeric) == .orderedAscending {
            throw ClientValidationError.unsupportedVersion(found: version, minimum: minimumVersion)
        }

        logger.debug("Validated client at \(bundlePath) with version \(version).")
    }
}
