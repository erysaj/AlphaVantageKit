//
//  GlobalQuoteTests.swift
//  
//
//  Created by Eugene Rysaj on 12.06.2020.
//

import XCTest
import AlphaVantageStubs
@testable import AlphaVantageKit

final class GlobalQuoteTests: XCTestCase {
  let assets = AssetReader()

  func testDecoding() {
    let rs = try? assets.readJSON(GlobalQuoteRs.self, path: "global_quote.json")
    XCTAssertNotNil(rs)

    let quote = rs!.quote
    XCTAssertEqual(quote.symbol, "MSFT")
    XCTAssertEqual(quote.open, "138.8500")
    XCTAssertEqual(quote.high, "139.1300")
    XCTAssertEqual(quote.low, "138.0100")
    XCTAssertEqual(quote.price, "138.9000")
    XCTAssertEqual(quote.volume, "17725458")
    XCTAssertEqual(quote.latestTradingDay, "2019-07-12")
    XCTAssertEqual(quote.prevClose, "138.4000")
    XCTAssertEqual(quote.change, "0.5000")
    XCTAssertEqual(quote.changePercent, "0.3613%")
  }

  static var allTests = [
    ("testDecoding", testDecoding),
  ]
}
