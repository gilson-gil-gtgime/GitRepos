//
//  HomeInteractorSpec.swift
//  GitRepos
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright (c) 2019 Gilson Gil. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import GitRepos

import Quick
import Nimble

final class HomeInteractorSpec: QuickSpec {
  override func spec() {
    let sut = HomeInteractor()

    describe("given an home interactor") {
      context("when fetching first page") {
        let request = Home.FetchRepositories.Request(refresh: false)
        sut.fetchNextPage(request: request)
        it("should have currentPage == 1") {
          expect(sut.currentPage).toEventually(equal(1),
                                               timeout: 5,
                                               pollInterval: 1,
                                               description: nil)
        }
        it("should have 20 repositories") {
          expect(sut.repositories.count).toEventually(equal(20),
                                                      timeout: 5,
                                                      pollInterval: 1,
                                                      description: nil)
        }
      }
    }
  }
}
