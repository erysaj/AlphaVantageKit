//
//  SymbolSearch.swift
//  
//
//  Created by Eugene Rysaj on 05.03.2020.
//

import Foundation

struct SymbolSearchRq : ApiRequest {
  typealias Response = SymbolSearchRs

  let keywords: String

  var queryItems: [URLQueryItem] {
    return [
      URLQueryItem(name: "function", value: "SYMBOL_SEARCH"),
      URLQueryItem(name: "keywords", value: keywords),
    ]
  }
}

public struct SymbolSearchRs : Decodable {

  public struct Match : Codable {
    public var symbol: String
    public var name: String
    public var type: String
    public var region: String
    public var marketOpen: String
    public var marketClose: String
    public var timezone: String
    public var currency: String
    public var matchScore: String

    private enum CodingKeys: String, CodingKey {
      case symbol = "1. symbol"
      case name = "2. name"
      case type = "3. type"
      case region = "4. region"
      case marketOpen = "5. marketOpen"
      case marketClose = "6. marketClose"
      case timezone = "7. timezone"
      case currency = "8. currency"
      case matchScore = "9. matchScore"
    }
  }

  public var bestMatches: [Match]
}
