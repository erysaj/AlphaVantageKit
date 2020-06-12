//
//  Date.swift
//  
//
//  Created by Eugene Rysaj on 05.03.2020.
//

public struct Date : Equatable, Hashable, Comparable {
  public let year: Int16
  public let month: Int8
  public let day: Int8

  public static func == (lhs: Date, rhs: Date) -> Bool {
    return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
  }

  public static func < (lhs: Date, rhs: Date) -> Bool {
    if lhs.year != rhs.year {
      return lhs.year < rhs.year
    }
    if lhs.month != rhs.month {
      return lhs.month < rhs.month
    }
    if lhs.day != rhs.day {
      return lhs.day < rhs.day
    }
    return false
  }
}

extension Date : LosslessStringConvertible {
  public init?(_ description: String) {
    switch Date.parse(description) {
    case .success(let date):
      year = date.year
      month = date.month
      day = date.day
    case .failure(_):
      return nil
    }
  }
  
  public var description: String {
    String(format: "%04d-%02d-%02d", year, month, day)
  }
  
  public struct ParserError : Error {
    /// Position in parsed string where error was detected
    let pos: Int
    /// Explanation why went wrong
    let reason: String
  }

  enum ParserResult {
    case success(Date)
    case failure(ParserError)
  }

  /// Parser state machine
  private enum ParserState {
    /// Parsing YYYY part
    case yyyy(pos: Int, year: Int)
    /// Parsing MM part
    case mm(pos: Int, year: Int, month: Int)
    /// Parsing DD part
    case dd(pos: Int, year: Int, month: Int, day: Int)
    /// Error occured
    case error(ParserError)

    mutating func update(_ c: Character) {
      switch self {
        case .yyyy(let pos, let year):
          if pos <= 4 {
            guard c.isASCII && c.isWholeNumber else {
              self = .error(.init(pos: pos, reason: "Digit expected"))
              return
            }
            self = .yyyy(pos: pos + 1, year: 10 * year + c.wholeNumberValue!)
          }
          else {
            guard c == "-" else {
              self = .error(.init(pos: pos, reason: "'-' expected"))
              return
            }
            self = .mm(pos: pos + 1, year: year, month: 0)
          }
      case .mm(let pos, let year, let month):
        if pos <= 7 {
          guard c.isASCII && c.isWholeNumber else {
            self = .error(.init(pos: pos, reason: "Digit expected"))
            return
          }
          self = .mm(pos: pos + 1, year: year, month: 10 * month + c.wholeNumberValue!)
        }
        else {
          guard c == "-" else {
            self = .error(.init(pos: pos, reason: "'-' expected"))
            return
          }
          self = .dd(pos: pos + 1, year: year, month: month, day: 0)
        }
      case .dd(let pos, let year, let month, let day):
        if pos <= 10 {
          guard c.isASCII && c.isWholeNumber else {
            self = .error(.init(pos: pos, reason: "Digit expected"))
            return
          }
          self = .dd(pos: pos + 1, year: year, month: month, day: 10 * day + c.wholeNumberValue!)
        }
        else {
          self = .error(.init(pos: pos, reason: "End expected"))
        }
      case .error(_):
        break
      }
    }

    func finish() -> ParserResult {
      switch self {
      case .dd(11, let year, let month, let day):
        let date = Date(year: Int16(year), month: Int8(month), day: Int8(day))
        return .success(date)
      case .dd(let pos, _, _, _):
        return .failure(.init(pos: pos, reason: "Unexpected end"))
      case .mm(let pos, _, _):
        return .failure(.init(pos: pos, reason: "Unexpected end"))
      case .yyyy(let pos, _):
        return .failure(.init(pos: pos, reason: "Unexpected end"))
      case .error(let error):
        return .failure(error)
      }
    }
  }
  
  static func parse(_ s: String) -> ParserResult {
    var state: ParserState = .yyyy(pos: 1, year: 0)
    for c in s {
      state.update(c)
    }
    return state.finish()
  }
}

extension Date : Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let text = try container.decode(String.self)
    switch Date.parse(text) {
    case .success(let date):
      self.init(year: date.year, month: date.month, day: date.day)
    case .failure(let err):
      throw err
    }
  }
}
