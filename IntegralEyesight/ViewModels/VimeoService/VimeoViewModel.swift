import Foundation
import SwiftUI

/// A view model for interfacing with the Vimeo API.
///
/// This class provides functionalities to fetch folders and videos from the Vimeo API
/// and keeps track of the loading state for these operations.
/// It uses a service conforming to `VimeoServiceProtocol` to perform the actual data fetching tasks.
@MainActor
final class VimeoViewModel: ObservableObject {

    private var vimeoService: VimeoServiceProtocol

    /// An array of folders in the root folder of the Vimeo account.
    @Published private(set) var foldersInRootFolder: [Folder] = []

    /// A Boolean indicating whether the fetch operation for folders in the root is currently loading.
    @Published private(set) var isFetchFoldersInRootLoading: Bool = true

    /// A Boolean indicating whether the fetch operation for videos in a course folder is currently loading.
    @Published private(set) var isFetchVideosInCourseLoading: Bool = true

    /// Initializes the view model with a Vimeo service.
    ///
    /// - Parameter service: An instance of a class conforming to `VimeoServiceProtocol`.
    init(service: VimeoServiceProtocol) {
        self.vimeoService = service
    }

    /// Fetches folders located in the root folder of the Vimeo account.
    ///
    /// Updates `foldersInRootFolder` and `isFetchFoldersInRootLoading` accordingly.
    func fetchFoldersInRootFolder() async throws {
        self.isFetchFoldersInRootLoading = true
        defer { self.isFetchFoldersInRootLoading = false }
        self.foldersInRootFolder = try await vimeoService.fetchFoldersInRootFolder()
    }

    /// Fetches videos from a specified course folder.
    ///
    /// - Parameter folderUrl: The URL of the course folder.
    /// - Returns: An array of `VideoItem` objects representing videos in the course folder.
    func fetchVideosInCourseFolder(from folderUrl: String)  async throws -> [VideoItem] {
        self.isFetchVideosInCourseLoading = true
        defer { self.isFetchVideosInCourseLoading = false }
        return try await vimeoService.fetchVideosInCourseFolder(from: folderUrl)
    }

    /// Retrieves a link for a specified video.
    ///
    /// - Parameters:
    ///   - video: The `Video` object for which to retrieve the link.
    ///   - quality: The desired quality of the video.
    ///   - rendition: The desired rendition of the video.
    /// - Returns: A string containing the link to the video.
    func getLink(for video: Video, withQuality quality: String, andRendition rendition: String) -> String? {
        return vimeoService.getLink(for: video, withQuality: quality, andRendition: rendition)
    }

    /// Fetches an image from a specified URL.
    ///
    /// - Parameter url: The URL of the image.
    /// - Returns: A `UIImage` object fetched from the URL.
    func getImage(url: String) async throws -> UIImage? {
        return try await vimeoService.getImage(url: url)
    }
}
