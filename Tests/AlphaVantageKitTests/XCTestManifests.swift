import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AlphaVantageKitTests.allTests),
    ]
}
#endif
