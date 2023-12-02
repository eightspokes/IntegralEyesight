import Foundation
import SwiftUI

/// Defines the required functionalities for a service interacting with the Vimeo API.
///
/// This protocol specifies methods for fetching folders and videos from Vimeo,
/// retrieving links for videos, and fetching images from URLs.
/// It also defines properties to access the user ID, root folder ID, and API key,
/// which are essential for making requests to the Vimeo API.
protocol VimeoServiceProtocol {
    /// Fetches folders located in the root folder of the Vimeo account.
    ///
    /// - Returns: An array of `Folder` objects representing folders in the root.
    /// - Throws: An error if the fetch operation fails.
    func fetchFoldersInRootFolder() async throws -> [Folder]

    /// Fetches videos from a specified course folder on Vimeo.
    ///
    /// - Parameter folderUrl: The URL of the course folder.
    /// - Returns: An array of `VideoItem` objects representing videos in the course folder.
    /// - Throws: An error if the fetch operation fails.
    func fetchVideosInCourseFolder(from folderUrl: String) async throws -> [VideoItem]

    /// Retrieves a link for a specified video.
    ///
    /// - Parameters:
    ///   - video: The `Video` object for which to retrieve the link.
    ///   - quality: The desired quality of the video.
    ///   - rendition: The desired rendition of the video.
    /// - Returns: A string containing the link to the video, or `nil` if not available.
    func getLink(for video: Video, withQuality quality: String, andRendition rendition: String) -> String?

    /// Fetches an image from a specified URL.
    ///
    /// - Parameter url: The URL of the image.
    /// - Returns: A `UIImage` object fetched from the URL, or `nil` if not available.
    /// - Throws: An error if the fetch operation fails.
    func getImage(url: String) async throws -> UIImage?

    /// The user ID associated with the Vimeo account.
    var userId: String { get }

    /// The ID of the root folder in the Vimeo account.
    var rootFolderId: String { get }

    /// The API key for accessing Vimeo's API.
    var apiKey: String { get }
}
