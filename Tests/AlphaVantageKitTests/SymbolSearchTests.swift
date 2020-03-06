//
//  SymbolSearchTests.swift
//  
//
//  Created by Eugene Rysaj on 05.03.2020.
//

import XCTest
import AlphaVantageStubs
@testable import AlphaVantageKit

final class SymbolSearchTests: XCTestCase {
  let assets = AssetReader()

  func testDecoding() {
    let rs = try? assets.readJSON(SymbolSearchRs.self, path: "search_results.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
    ("testDecoding", testDecoding),
  ]
}
