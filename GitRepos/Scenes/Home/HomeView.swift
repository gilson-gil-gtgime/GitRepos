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
  var refreshControl: UIRefreshControl { get }
  var viewInteractions: HomeViewInteractions? { get set }
}

protocol HomeViewInteractions: class {
  func didPullRefresh(at view: HomeView)
}

final class HomeView: UIView, HomeViewLogic {
  public private(set) var tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .clear
    tableView.separatorStyle = .none
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 80
    tableView.allowsSelection = false
    tableView.accessibilityLabel = "tableView"
    tableView.accessibilityIdentifier = "tableView"
    return tableView
  }()

  public private(set) lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = .white
    refreshControl.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
    return refreshControl
  }()

  weak var viewInteractions: HomeViewInteractions?

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
    tableView.addSubview(refreshControl)
  }

  private func addConstraints() {
    constrain(self, tableView) { view, tableView in
      tableView.edges == view.edges
    }
  }
}

// MARK: - Actions
@objc
extension HomeView {
  func refreshPulled() {
    viewInteractions?.didPullRefresh(at: self)
  }
}
