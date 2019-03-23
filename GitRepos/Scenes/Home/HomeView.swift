//
//  HomeView.swift
//  GitRepos
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

protocol HomeViewLogic: class {
  var tableView: UITableView { get }
}

final class HomeView: UIView, HomeViewLogic {
  public private(set) var tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .clear
    tableView.separatorStyle = .none
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 80
    tableView.allowsSelection = false
    return tableView
  }()

  init() {
    super.init(frame: .zero)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(frame: .zero)
    setup()
  }

  // MARK: - Setup

  private func setup() {
    backgroundColor = UIColor(red: 38 / 255, green: 55 / 255, blue: 87 / 255, alpha: 1)

    addSubviews()
    addConstraints()
  }

  private func addSubviews() {
    addSubview(tableView)
  }

  private func addConstraints() {
    constrain(self, tableView) { view, tableView in
      tableView.edges == view.edges
    }
  }
}
