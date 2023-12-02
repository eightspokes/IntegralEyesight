import SwiftUI

/// A mock implementation of `VimeoServiceProtocol` for testing purposes.
///
/// This class simulates interactions with the Vimeo API by providing predefined responses.
/// It is used in tests to verify the behaviors of components that depend on the Vimeo service
/// without making actual network requests. The class contains mock data properties for folders,
/// video items, user ID, root folder ID, API key, link, and image that can be customized for different test scenarios.
class MockVimeoService: VimeoServiceProtocol {
    var mockFolders: [Folder] = []
    var mockVideoItems: [VideoItem] = []
    var mockUserId = "mockUserId"
    var mockRootFolderId = "mockRootFolderId"
    var mockApiKey = "mockApiKey"
    var mockLink: String? = "mockLink"
    var mockImage: UIImage? = UIImage()

    /// Simulates fetching folders in the root folder.
    ///
    /// Returns predefined folders set in `mockFolders`.
    func fetchFoldersInRootFolder() async throws -> [Folder] {
        return mockFolders
    }

    /// Simulates fetching videos in a course folder.
    ///
    /// Returns predefined video items set in `mockVideoItems`.
    /// - Parameter folderUrl: The URL of the folder from which to fetch videos.
    func fetchVideosInCourseFolder(from folderUrl: String) async throws -> [VideoItem] {
        return mockVideoItems
    }

    /// Simulates getting a link for a video.
    ///
    /// Returns a predefined link set in `mockLink`.
    /// - Parameters:
    ///   - video: The video for which to get the link.
    ///   - quality: The desired quality of the video.
    ///   - rendition: The desired rendition of the video.
    func getLink(for video: Video, withQuality quality: String, andRendition rendition: String) -> String? {
        return mockLink
    }

    /// Simulates fetching an image from a URL.
    ///
    /// Returns a predefined image set in `mockImage`.
    /// - Parameter url: The URL from which to fetch the image.
    func getImage(url: String) async throws -> UIImage? {
        return mockImage
    }

    /// Mock user ID.
    var userId: String { mockUserId }

    /// Mock root folder ID.
    var rootFolderId: String { mockRootFolderId }

    /// Mock API key.
    var apiKey: String { mockApiKey }
}
