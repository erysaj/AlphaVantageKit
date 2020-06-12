//
//  DateTests.swift
//  
//
//  Created by Eugene Rysaj on 12.06.2020.
//

import XCTest
@testable import AlphaVantageKit

final class DateTests: XCTestCase {

  func testConversions() {
    XCTAssertEqual(Date("2020-06-01"), Date(year: 2020, month: 6, day: 1))
    XCTAssertEqual(String(describing: Date(year: 2020, month: 6, day: 1)), "2020-06-01")
  }

  static var allTests = [
    ("testConversions", testConversions),
  ]
}
