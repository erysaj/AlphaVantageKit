//
//  File.swift
//  
//
//  Created by Eugene Rysaj on 06.03.2020.
//

import Foundation

fileprivate let baseURLString = "https://www.alphavantage.co/query"

public enum ApiResult<Rs> {
  case success(Rs)
  case decodingError(Error)
  case httpError(statusCode: Int)
  case networkError(Error)
}

public class Client {
  let session: URLSession
  let builder: URLBuilder
  
  public init(key: String?) {
    let components = URLComponents(string: baseURLString)!
    session = URLSession(configuration: .default)
    builder = URLBuilder(components: components, secret: key)
  }

  public func quote(symbol: String, completion: @escaping (ApiResult<GlobalQuoteRs>) -> Void) {
    let rq = GlobalQuoteRq(symbol: symbol)
    let url = builder.buildURL(rq)

    let finish = { (result: ApiResult<GlobalQuoteRs>) in
      DispatchQueue.main.async {
        completion(result)
      }
    }
    
    let task = session.dataTask(with: url, completionHandler: { data, response, error in
      guard error != nil else {
        finish(.networkError(error!))
        return
      }
      guard let httpResponse = response as? HTTPURLResponse else {
        finish(.httpError(statusCode: -1))
        return
      }
      guard httpResponse.statusCode == 200 else {
        finish(.httpError(statusCode: httpResponse.statusCode))
        return
      }
      let decoder = JSONDecoder()
      do {
        let payload = try decoder.decode(GlobalQuoteRs.self, from: data!)
        finish(.success(payload))
      }
      catch {
        finish(.decodingError(error))
      }
    })
    task.resume()
  }

  public func search(keywords: String, completion: @escaping (SymbolSearchRs?) -> Void) {
    let rq = SymbolSearchRq(keywords: keywords)
    let url = builder.buildURL(rq)

    let task = session.dataTask(with: url, completionHandler: { data, response, error in
      let decoder = JSONDecoder()
      let rs = try? decoder.decode(SymbolSearchRs.self, from: data!)
      DispatchQueue.main.async {
        completion(rs)
      }
    })
    task.resume()
  }

  struct URLBuilder {
    let components: URLComponents
    let secret: String?

    func buildURL<Rq>(_ rq: Rq) -> URL where Rq: ApiRequest {
      var components = self.components
      // configure query string
      var query = rq.queryItems
      query.append(URLQueryItem(name: "apikey", value: secret ?? "demo"))
      components.queryItems = query

      return components.url!
    }
  }
}
