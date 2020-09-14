import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(RampageFrameworkTests.allTests),
    ]
}
#endif
