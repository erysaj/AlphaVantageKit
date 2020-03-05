import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SymbolSearchTests.allTests),
        testCase(TimeSeriesTests.allTests),
    ]
}
#endif
