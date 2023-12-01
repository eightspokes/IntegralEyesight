//
//  IntegralEyesightTests.swift
//  IntegralEyesightTests
//
//  Created by Roman Kozulia on 11/11/23.
//

import XCTest
@testable import IntegralEyesight

final class VimeoServiceTests: XCTestCase {

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

            // Await to hop back to the main thread for assertions
                   await withCheckedContinuation { continuation in
                       DispatchQueue.main.async {
                           XCTAssertFalse(self.viewModel.isFetchFoldersInRootLoading)
                           XCTAssertEqual(self.viewModel.foldersInRootFolder.count, 1)
                           continuation.resume()
                       }
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

    @MainActor 
    func testGetLink() {
        let mockService = MockVimeoService()
        let viewModel = VimeoViewModel(service: mockService)

        // Set up mock data
        let expectedLink = "https://example.com/video.mp4"
        mockService.mockLink = expectedLink

        // Test
        let video = Video.ExampleVideo
        let link = viewModel.getLink(for: video, withQuality: "hd", andRendition: "1080p")
        XCTAssertEqual(link, expectedLink, "The link should match the mock link")
    }
    func testGetImage() async throws {
        let mockService = MockVimeoService()
        let viewModel = await VimeoViewModel(service: mockService)

        // Setup mock data
        let expectedImage = UIImage(named: "testImage") // Replace with your test image
        mockService.mockImage = expectedImage

        // Perform the action
        let image = try await viewModel.getImage(url: "some/image/url")

        XCTAssertEqual(image, expectedImage, "The image should match the mock image")
    }
}
