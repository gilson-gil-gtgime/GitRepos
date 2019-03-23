//
//  ReuseIdentifiable.swift
//  GitRepos
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

protocol ReuseIdentifiable {
  static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
