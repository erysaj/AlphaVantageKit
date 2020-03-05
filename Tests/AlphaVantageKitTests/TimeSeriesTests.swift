//
//  TimeSeriesTests.swift
//  
//
//  Created by Eugene Rysaj on 05.03.2020.
//

import XCTest
import TestResources
@testable import AlphaVantageKit

final class TimeSeriesTests: XCTestCase {
  let loader = Loader()
  
  func testDecodingCompact() {
    let rs = try? loader.loadJSON(TimeSeriesRs.self, path: "daily_MSFT_compact.json")
    XCTAssertNotNil(rs)

    if let meta = rs?.meta {
      XCTAssertTrue(meta.information.starts(with: "Daily Prices"))
      XCTAssertEqual(meta.symbol, "MSFT")
      XCTAssertEqual(meta.lastRefreshed.year, 2019)
      XCTAssertEqual(meta.lastRefreshed.month, 7)
      XCTAssertEqual(meta.lastRefreshed.day, 12)
    }
  }

  static var allTests = [
      ("testDecoding", testDecodingCompact),
  ]
}
