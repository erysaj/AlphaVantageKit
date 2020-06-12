//
//  TimeSeriesTests.swift
//  
//
//  Created by Eugene Rysaj on 05.03.2020.
//

import XCTest
import AlphaVantageStubs
@testable import AlphaVantageKit

final class TimeSeriesTests: XCTestCase {
  let assets = AssetReader()
  
  func testDecodingCompact() {
    let rs = try? assets.readJSON(TimeSeriesRs.self, path: "daily_MSFT_compact.json")
    XCTAssertNotNil(rs)

    if let meta = rs?.meta {
      XCTAssertTrue(meta.information.starts(with: "Daily Prices"))
      XCTAssertEqual(meta.symbol, "MSFT")
      XCTAssertEqual(meta.lastRefreshed, Date.init(year: 2019, month: 7, day: 12))
      XCTAssertEqual(meta.outputSize, OutputSize.compact)
    }
  }

  func testDecodingFull() {
    let rs = try? assets.readJSON(TimeSeriesRs.self, path: "daily_MSFT_full.json")
    XCTAssertNotNil(rs)

    if let meta = rs?.meta {
      XCTAssertTrue(meta.information.starts(with: "Daily Prices"))
      XCTAssertEqual(meta.symbol, "MSFT")
      XCTAssertEqual(meta.lastRefreshed, Date.init(year: 2019, month: 7, day: 12))
      XCTAssertEqual(meta.outputSize, OutputSize.full)
    }
  }


  static var allTests = [
      ("testDecoding", testDecodingCompact),
  ]
}
