//
//  GlobalQuote.swift
//  
//
//  Created by Eugene Rysaj on 12.06.2020.
//

import Foundation

struct GlobalQuoteRq : ApiRequest {
  typealias Response = GlobalQuoteRs

  let symbol: String

  var queryItems: [URLQueryItem] {
    return [
      URLQueryItem(name: "function", value: "GLOBAL_QUOTE"),
      URLQueryItem(name: "symbol", value: symbol),
    ]
  }
}

public struct GlobalQuoteRs: Decodable {
  public struct Quote: Decodable {
    public var symbol: String
    public var open: String
    public var high: String
    public var low: String
    public var price: String
    public var volume: String
    public var latestTradingDay: String
    public var prevClose: String
    public var change: String
    public var changePercent: String
    
    private enum CodingKeys: String, CodingKey {
      case symbol = "01. symbol"
      case open = "02. open"
      case high = "03. high"
      case low = "04. low"
      case price = "05. price"
      case volume = "06. volume"
      case latestTradingDay = "07. latest trading day"
      case prevClose = "08. previous close"
      case change = "09. change"
      case changePercent = "10. change percent"
    }
  }

  public var quote: Quote
 
  private enum CodingKeys: String, CodingKey {
    case quote = "Global Quote"
  }
}
