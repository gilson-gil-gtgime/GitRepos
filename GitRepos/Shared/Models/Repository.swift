//
//  Repository.swift
//  GitRepos
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct Repository: Decodable {
  let identifier: Int
  let name: String
  let fullName: String
  let owner: Owner
  let stars: Int

  enum CodingKeys: String, CodingKey {
    case name, fullName, owner
    case identifier = "id"
    case stars = "stargazersCount"
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    stars = try container.decode(Int.self, forKey: .stars)
    identifier = try container.decode(Int.self, forKey: .identifier)
    name = try container.decode(String.self, forKey: .name)
    fullName = try container.decode(String.self, forKey: .fullName)
    owner = try container.decode(Owner.self, forKey: .owner)
  }
}
