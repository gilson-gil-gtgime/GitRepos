//
//  RepositoryResult.swift
//  GitRepos
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct RepositoryResult: Decodable {
  let repositories: [Repository]

  enum CodingKeys: String, CodingKey {
    case repositories = "items"
  }
}
