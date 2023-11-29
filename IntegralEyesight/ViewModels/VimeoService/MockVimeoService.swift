//
//  VimeoViewModelTests.swift
//  IntegralEyesightTests
//
//  Created by Roman Kozulia on 11/28/23.
//
import SwiftUI

class MockVimeoService: VimeoServiceProtocol {
    var mockFolders: [Folder] = []
    var mockVideoItems: [VideoItem] = []
    var mockUserId = "mockUserId"
    var mockRootFolderId = "mockRootFolderId"
    var mockApiKey = "mockApiKey"
    var mockLink: String? = "mockLink"
    var mockImage: UIImage? = UIImage()

    func fetchFoldersInRootFolder() async throws -> [Folder] {
        return mockFolders
    }

    func fetchVideosInCourseFolder(from folderUrl: String) async throws -> [VideoItem] {
        return mockVideoItems
    }

    func getLink(for video: Video, withQuality quality: String, andRendition rendition: String) -> String? {
        return mockLink
    }

    func getImage(url: String) async throws -> UIImage? {
        return mockImage
    }

    var userId: String { mockUserId }
    var rootFolderId: String { mockRootFolderId }
    var apiKey: String { mockApiKey }
}

