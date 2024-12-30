import XCTest

final class SampleUITest: XCTestCase {
    // We'll keep a reference to our application instance that we can use across test methods
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Start with a fresh state for each test
        continueAfterFailure = false

        // Initialize our app instance
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        // Clean up our app reference after each test
        app = nil
    }

    func testMainWindowShowsWelcomeText() throws {
        // Launch the application
        app.launch()

        // On macOS, we need to wait a moment for the window to appear and stabilize
        // This helps prevent flaky tests
        let window = app.windows.firstMatch
        XCTAssertTrue(window.waitForExistence(timeout: 5))

        // Look for our welcome text using the exact string
        let welcomeText = app.staticTexts["Hello, Kid Promises!"]

        // Verify the text exists and is displayed
        XCTAssertTrue(welcomeText.exists, "Welcome text should be visible")
        XCTAssertTrue(welcomeText.isHittable, "Welcome text should be interactive")
    }
}
