//
//  APISpec.swift
//  GitReposTests
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import GitRepos

import Quick
import Nimble

final class APISpec: QuickSpec {
  override func spec() {
    let sut = API.self

    describe("given an API") {
      context("when fetching a page of repositories") {
        it("should return a valid list of repositories or return endReached error") {
          waitUntil(timeout: 5) { finished in
            sut.getRepositories(page: 0) { callback in
              do {
                let repositories = try callback()
                expect(repositories).toNot(beEmpty())
              } catch {
                expect(error).to(beAKindOf(APIError.self))
              }
              finished()
            }
          }
        }
      }
    }
  }
}

