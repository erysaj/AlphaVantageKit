//
//  SymbolSearchTests.swift
//  
//
//  Created by Eugene Rysaj on 05.03.2020.
//

import XCTest
import TestResources
@testable import AlphaVantageKit

final class SymbolSearchTests: XCTestCase {
  let loader = Loader()

  func testDecoding() {
    let rs = try? loader.loadJSON(SymbolSearchRs.self, path: "search_results.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
    ("testDecoding", testDecoding),
  ]
}
