import XCTest
@testable import WKTypeScript

final class WKTypeScriptTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WKTypeScript().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
