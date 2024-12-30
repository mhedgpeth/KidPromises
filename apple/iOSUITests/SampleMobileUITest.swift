import XCTest

final class SampleUITest: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testMainWindowShowsWelcomeText() throws {
        // Launch the application
        app.launch()

        // On iOS, we don't need to check for windows explicitly like in macOS
        // Instead, we can directly look for UI elements on the screen
        let welcomeText = app.staticTexts["Hello, People Work!"]

        // Give a small amount of time for the UI to settle
        // This is typically needed for iOS animations and view controller transitions
        XCTAssertTrue(welcomeText.waitForExistence(timeout: 2))

        // On iOS, being "hittable" is more relevant than on macOS
        // as it confirms the element isn't covered by other views
        XCTAssertTrue(welcomeText.isHittable, "Welcome text should be visible and interactable")
    }
}
