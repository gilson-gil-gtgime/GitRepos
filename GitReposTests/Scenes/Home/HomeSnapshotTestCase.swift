//
//  HomeSnapshotTestCase.swift
//  GitReposTests
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import GitRepos

import Foundation

import KIF
import FBSnapshotTestCase

class HomeSnapshotTestCase: FBSnapshotTestCase {
  func testHome() {
//    recordMode = true
    KIFEnableAccessibility()
    let sut = HomeViewController()
    let window = UIWindow()
    window.rootViewController = sut
    window.makeKeyAndVisible()

    tester().waitForAnimationsToFinish()
    let tableView = self.tester().waitForView(withAccessibilityLabel: "tableView") as? UITableView
    _ = self.tester().waitForCell(at: IndexPath(row: 0, section: 0), in: tableView)

    tester().waitForAnimationsToFinish()
    FBSnapshotVerifyView(sut.view)
  }
}
