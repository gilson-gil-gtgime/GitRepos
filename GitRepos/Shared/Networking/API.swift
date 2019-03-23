//
//  API.swift
//  GitRepos
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum APIError: LocalizedError {
  case endReached
  case custom(String)

  var errorDescription: String? {
    switch self {
    case .custom(let message):
      return message
    default:
      return localizedDescription
    }
  }
}

struct API {
  private static var baseUrlString: String {
    return "https://api.github.com"
//    https://api.github.com/search/repositories?q=language:swift&sort=stars&page=1&per_page=2
  }

  public static var baseUrl: URL {
    guard let url = URL(string: baseUrlString) else { fatalError("invalid base url") }
    return url
  }

  enum Endpoints: String {
    case searchRepos = "/search/repositories"
  }

  static func getRepositories(page: Int, completion: @escaping (() throws -> [Repository]) -> Void) {
    let method = Method.get
    let path = Endpoints.searchRepos.rawValue
    let parameters: Parameters = [
      "q": "language:swift",
      "sort": "stars",
      "per_page": Constants.repositoriesPerPage,
      "page": page
    ]
    HTTPService.request(method: method, baseUrl: baseUrl, path: path, parameters: parameters) { callback in
      do {
        let data = try callback()
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let repositories = try decoder.decode(RepositoryResult.self, from: data).repositories
        if repositories.isEmpty {
          completion { throw APIError.endReached }
        } else {
          completion { repositories }
        }
      } catch {
        completion { throw error }
      }
    }
  }
}
