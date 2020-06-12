//
//  File.swift
//  
//
//  Created by Eugene Rysaj on 06.03.2020.
//

import Foundation

fileprivate let baseURLString = "https://www.alphavantage.co/query"

public enum ApiResponse<Rs> {
  case success(payload: Rs)
  case decodingError(Error)
  case httpError(httpCode: Int)
  case networkError(Error)
}

public class Client {
  let session: URLSession
  let builder: URLBuilder
  
  public init(key: String) {
    let components = URLComponents(string: baseURLString)!
    session = URLSession(configuration: .default)
    builder = URLBuilder(components: components, secret: key)
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
    let secret: String

    func buildURL<Rq>(_ rq: Rq) -> URL where Rq: ApiRequest {
      var components = self.components
      // configure query string
      var query = rq.queryItems
      query.append(URLQueryItem(name: "apikey", value: secret))
      components.queryItems = query

      return components.url!
    }
  }
}
