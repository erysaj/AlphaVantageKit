//
//  TimeSeries.swift
//  
//
//  Created by Eugene Rysaj on 05.03.2020.
//

import Foundation

public enum OutputSize: String, Decodable {
  case compact = "Compact"
  case full = "Full size"
}

public struct TimeSeriesRs {
  var meta: Meta
  var rows: Dictionary<Date, Row>;

  private enum CodingKeys: String, CodingKey {
      case meta = "Meta Data"
      case rows = "Time Series (Daily)"
  }

  public struct Meta: Decodable {
    var information: String
    var symbol: String
    var lastRefreshed: Date
    var outputSize: OutputSize
    var timeZone: String

    private enum CodingKeys: String, CodingKey {
      case information = "1. Information"
      case symbol = "2. Symbol"
      case lastRefreshed = "3. Last Refreshed"
      case outputSize = "4. Output Size"
      case timeZone = "5. Time Zone"
    }
  }

  public struct Row : Codable {
    var open: String
    var high: String
    var low: String
    var close: String
    var volume: String
    
    private enum CodingKeys: String, CodingKey {
      case open = "1. open"
      case high = "2. high"
      case low = "3. low"
      case close = "4. close"
      case volume = "5. volume"
    }
  }
}

extension TimeSeriesRs : Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let meta = try container.decode(Meta.self, forKey: .meta)
    let rowsContainer = try container.nestedContainer(keyedBy: DynamicKey.self, forKey: .rows)
    var rows = Dictionary<Date, Row>()
    try rowsContainer.allKeys.forEach { key in
      let date = try Date.init(key.stringValue)
      let row = try rowsContainer.decode(Row.self, forKey: key)
      rows[date] = row
    }
    self.init(meta: meta, rows: rows)
  }
}
