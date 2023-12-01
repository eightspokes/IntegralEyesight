//
//  FavoriteVideosTests.swift
//  IntegralEyesightTests
//
//  Created by Roman Kozulia on 11/29/23.
//

import XCTest
@testable import IntegralEyesight
final class FavoriteVideosTests: XCTestCase {

    var viewModel: FavoriteVideosViewModel!
        var mockStorageService: MockFavoritesStorageService!

    @MainActor override func setUp() {
            super.setUp()
            mockStorageService = MockFavoritesStorageService()
            viewModel = FavoriteVideosViewModel(storageService: mockStorageService)
        }

        override func tearDown() {
            viewModel = nil
            mockStorageService = nil
            super.tearDown()
        }

    @MainActor func testAddVideo() {
            let testVideo = Video.ExampleVideo

            XCTAssertFalse(viewModel.favoriteVideos.contains(testVideo))
            XCTAssertFalse(mockStorageService.saveWasCalled)

             viewModel.add(testVideo)

            XCTAssertTrue(viewModel.favoriteVideos.contains(testVideo))
        }
   @MainActor func testRemoveVideo() {
        let testVideo = Video.ExampleVideo
          viewModel.add(testVideo)
         XCTAssertTrue(viewModel.favoriteVideos.contains(testVideo))
         viewModel.remove(testVideo)
         XCTAssertFalse(viewModel.favoriteVideos.contains(testVideo))
     }
}
