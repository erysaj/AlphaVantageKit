//
//  ApiRequest.swift
//  
//
//  Created by Eugene Rysaj on 06.03.2020.
//

import Foundation

protocol ApiRequest {
  associatedtype Response

  var queryItems: [URLQueryItem] { get }
}
