//
//  HomeRepositoryCellSpec.swift
//  GitReposTests
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import GitRepos

import Quick
import Nimble

final class HomeRepositoryCellSpec: QuickSpec {
  override func spec() {
    let sut = HomeRepositoryCell(style: .default, reuseIdentifier: HomeRepositoryCell.reuseIdentifier)
    sut.didMoveToSuperview()

    describe("given an home repository cell") {
      context("when successfully loaded") {
        it("should have empty labels") {
          expect((sut.viewWithTag(1) as? UILabel)?.text).to(beNil())
          expect((sut.viewWithTag(2) as? UILabel)?.text).to(beNil())
          expect((sut.viewWithTag(3) as? UILabel)?.text).to(beNil())
        }
      }

      context("when updating with a repo") {
        it("should display correct values") {
          let name = "swifteiro"
          let stars = "45632"
          let authorName = "Gilson Gil"
          let avatarUrl = "https://avatars3.githubusercontent.com/u/11818246?s=460&v=4"
          let repository = Home.DisplayedRepository(name: name,
                                                    stars: stars,
                                                    authorName: authorName,
                                                    authorAvatarUrl: avatarUrl)
          sut.update(with: repository)
          expect((sut.viewWithTag(1) as? UILabel)?.text).to(equal(name))
          expect((sut.viewWithTag(2) as? UILabel)?.text).to(equal(stars))
          expect((sut.viewWithTag(3) as? UILabel)?.text).to(equal(authorName))
          expect((sut.viewWithTag(4) as? URLImageView)?.imageUrl).to(equal(avatarUrl))
        }
      }
    }
  }
}
