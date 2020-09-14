import XCTest
@testable import RampageFramework

final class RampageFrameworkTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RampageFramework.version, "1.0.0")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
