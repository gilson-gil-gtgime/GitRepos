//
//  HomeTestCase.swift
//  GitReposTests
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import GitRepos

import Foundation

import KIF
import Quick
import Nimble

class HomeTestCase: QuickSpec {
  override func spec() {
    KIFEnableAccessibility()
    let sut = HomeViewController()
    let window = UIWindow()
    window.rootViewController = sut
    window.makeKeyAndVisible()

    describe("home view controller") {
      context("load") {
        it("should show correct info on cells") {
          self.tester().waitForAnimationsToFinish()
          let tableView = self.tester().waitForView(withAccessibilityLabel: "tableView") as? UITableView
          let cell = self.tester().waitForCell(at: IndexPath(row: 0, section: 0), in: tableView)
          let repository = sut.displayedRepositories?.first
          expect((cell?.viewWithTag(1) as? UILabel)?.text).to(equal(repository?.name))
          expect((cell?.viewWithTag(2) as? UILabel)?.text).to(equal(repository?.stars))
          expect((cell?.viewWithTag(3) as? UILabel)?.text).to(equal(repository?.authorName))
        }
      }
    }
  }
}
