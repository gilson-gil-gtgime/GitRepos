//
//  HomeRepositoryCell.swift
//  GitRepos
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

protocol HomeRepositoryCellLogic: class {
  func update(with displayedRepository: Home.DisplayedRepository)
}

final class HomeRepositoryCell: UITableViewCell {
  private let bgView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 5
    return view
  }()

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.tag = 1
    return label
  }()

  private let starsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.tag = 2
    return label
  }()

  private let authorNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.tag = 3
    return label
  }()

  private let authorAvatarImageView: URLImageView = {
    let imageView = URLImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 4
    imageView.tag = 4
    return imageView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(style: .default, reuseIdentifier: HomeRepositoryCell.reuseIdentifier)
    setup()
  }

  // MARK: - Setup

  private func setup() {
    backgroundColor = .clear

    addSubviews()
    addConstraints()
  }

  private func addSubviews() {
    addSubview(bgView)
    bgView.addSubview(nameLabel)
    bgView.addSubview(starsLabel)
    bgView.addSubview(authorNameLabel)
    bgView.addSubview(authorAvatarImageView)
  }

  private func addConstraints() {
    let margin: CGFloat = 20

    constrain(self, bgView) { cell, bgView in
      bgView.top == cell.top + margin / 2
      bgView.left == cell.left + margin
      bgView.bottom == cell.bottom - margin / 2
      bgView.right == cell.right - margin
    }

    constrain(
      bgView,
      nameLabel,
      starsLabel,
      authorNameLabel,
      authorAvatarImageView) { bgView, nameLabel, starsLabel, authorNameLabel, authorAvatarImageView in
        nameLabel.top == bgView.top + margin
        nameLabel.left == bgView.left + margin

        authorAvatarImageView.top == bgView.top + margin
        authorAvatarImageView.left == nameLabel.right + margin
        authorAvatarImageView.bottom == bgView.bottom - margin
        authorAvatarImageView.right == bgView.right - margin
        authorAvatarImageView.width == authorAvatarImageView.height

        starsLabel.top == nameLabel.bottom + margin
        starsLabel.left == nameLabel.left
        starsLabel.bottom == bgView.bottom - margin

        authorNameLabel.right == authorAvatarImageView.left - margin
        authorNameLabel.centerY == starsLabel.centerY
    }
  }
}

// MARK: - HomeRepositoryCell Logic
extension HomeRepositoryCell: HomeRepositoryCellLogic {
  func update(with displayedRepository: Home.DisplayedRepository) {
    nameLabel.text = displayedRepository.name
    starsLabel.text = displayedRepository.stars
    authorNameLabel.text = displayedRepository.authorName
    authorAvatarImageView.imageUrl = displayedRepository.authorAvatarUrl
  }
}

// MARK: - ReuseIdentifiable
extension HomeRepositoryCell: ReuseIdentifiable {}
