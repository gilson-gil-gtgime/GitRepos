//
//  Owner.swift
//  GitRepos
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct Owner: Decodable {
  let name: String
  let avatarUrl: String

  enum CodingKeys: String, CodingKey {
    case name = "login"
    case avatarUrl
  }
}
