//
//  IntegralEyesightTests.swift
//  IntegralEyesightTests
//
//  Created by Roman Kozulia on 11/11/23.
//

import XCTest
@testable import IntegralEyesight

final class IntegralEyesightTests: XCTestCase {

    var viewModel: VimeoViewModel!
        var mockService: MockVimeoService!

    @MainActor override func setUp() {
            super.setUp()
            mockService = MockVimeoService()
            viewModel = VimeoViewModel(service: mockService)
        }

        override func tearDown() {
            viewModel = nil
            mockService = nil
            super.tearDown()
        }
    func testFetchFoldersInRootFolder() async {
        // Setup mock data
        mockService.mockFolders = [Folder(createdTime: "", modifiedTime: "", lastUserActionEventDate: "", name: "", privacy: Privacy(view: "" ),  resourceKey: "",  uri: "")]

        do {
               // Perform the action
               try await viewModel.fetchFoldersInRootFolder()

               // Assert results if the call was successful
               await Task { @MainActor in
                   XCTAssertFalse(viewModel.isFetchFoldersInRootLoading)
                   XCTAssertEqual(viewModel.foldersInRootFolder.count, 1)
               }
           } catch {
               // Handle errors
               XCTFail("Error fetching folders: \(error)")
           }
    }
    func testFetchVideosInCourseFolder() async {
        // Setup mock data
        let video = Video.ExampleVideo
        mockService.mockVideoItems = [VideoItem(type: "video", video: video)]

        do {
            // Perform the action and get results
            let videoItems = try await viewModel.fetchVideosInCourseFolder(from: "testUrl")

            // Assert results
            await Task { @MainActor in
                XCTAssertEqual(videoItems.count, 1)
            }
        } catch {
            // Handle errors
            XCTFail("Error fetching videos: \(error)")
        }
    }

}
