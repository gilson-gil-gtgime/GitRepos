//
//  URLImageView.swift
//  GitRepos
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class URLImageView: UIImageView {
  var imageUrl: String? {
    willSet (value) {
      guard let value = value else { return image = nil }
      guard image == nil || value != imageUrl else { return }
      fetchImage(from: value)
    }
  }

  private func fetchImage(from urlString: String) {
    ImageWorker.shared.image(from: urlString) { [weak self] result in
      DispatchQueue.main.async {
        self?.image = result?.1
      }
    }
  }
}
