//
//  HTTPRequester.swift
//  GitRepos
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum Method: String {
  case get = "GET"
}

typealias Parameters = [String: Any]

extension Dictionary where Dictionary == Parameters {
  var getEncoded: [URLQueryItem] {
    var items: [URLQueryItem] = []
    for (key, value) in self {
      let item = URLQueryItem(name: key, value: String(describing: value))
      items.append(item)
    }
    return items
  }
}

struct HTTPService {
  static func request(method: Method, urlString: String, completion: @escaping (() throws -> Data) -> Void) -> URLSessionTask? {
    guard let url = URL(string: urlString) else {
      completion { throw HTTPError.unknown }
      return nil
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    return request(request: urlRequest, completion: completion)
  }

  static func request(method: Method, baseUrl: URL, path: String, completion: @escaping (() throws -> Data) -> Void) -> URLSessionTask? {
    let parameters: Parameters? = nil
    return request(method: method, baseUrl: baseUrl, path: path, parameters: parameters, completion: completion)
  }

  static func request(method: Method,
                      baseUrl: URL,
                      path: String,
                      parameters: Parameters?,
                      completion: @escaping (() throws -> Data) -> Void) -> URLSessionTask? {
    guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true) else { return nil }
    urlComponents.path = path
    urlComponents.queryItems = parameters?.getEncoded

    guard let url = urlComponents.url else { return nil }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

    return request(request: urlRequest, completion: completion)
  }

  static func request(request: URLRequest, completion: @escaping (() throws -> Data) -> Void) -> URLSessionTask? {
    let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
      print("--- [REQUEST] \(request.httpMethod ?? "") - \(request.url?.absoluteString ?? "")")
      print("--- [HEADER] \(request.allHTTPHeaderFields ?? [:])")
      if let body = request.httpBody {
        print("--- [BODY] \(String(data: body, encoding: String.Encoding.utf8) ?? "")")
      }
      if let status = (response as? HTTPURLResponse)?.statusCode {
        print("--- [STATUS] \(status)")
      }
      if let data = data {
        completion { data }
      } else if let err = err {
        completion { throw err }
      } else {
        completion { throw HTTPError.unknown }
      }
    }
    dataTask.resume()
    return dataTask
  }
}

