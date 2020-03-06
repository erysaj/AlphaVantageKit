//
//  Loader.swift
//  
//
//  Created by Eugene Rysaj on 05.03.2020.
//

import Foundation

public class AssetReader {
  private var baseURL: URL

  public init() {
    let thisFile = URL(fileURLWithPath: #file)
    let thisDir = thisFile.deletingLastPathComponent()
    baseURL = thisDir.appendingPathComponent("data")
  }

  public func read(path: String) throws -> Data {
    let fileURL = URL(string: path, relativeTo: baseURL)
    let data = try Data(contentsOf: fileURL!)
    return data
  }

  public func readJSON<T>(_ type: T.Type, path: String) throws -> T where T: Decodable {
    let decoder = JSONDecoder()
    let data = try read(path: path)
    return try decoder.decode(type, from: data)
  }
}
