import Foundation
import SwiftUI

/// A service class for interacting with the Vimeo API.
///
/// This class implements the `VimeoServiceProtocol` and provides methods to fetch data from Vimeo,
/// including folders, videos, links, and images. It handles API requests and responses,
/// and extracts configuration values like user ID and API key from a plist file.
final class VimeoService: VimeoServiceProtocol {
    private let baseUrl = "https://api.vimeo.com"

    /// The user ID for the Vimeo account, fetched from the plist file.
    var userId: String {
        return fetchValueFromPlist(forKey: "User_id")
    }

    /// The root folder ID for the Vimeo account, fetched from the plist file.
    var rootFolderId: String {
        return fetchValueFromPlist(forKey: "Root_folder_id")
    }

    /// The API key for accessing Vimeo, fetched from the plist file.
    var apiKey: String {
        let key = fetchValueFromPlist(forKey: "Api_key")
        if key.starts(with: "_") {
            fatalError("Register for a Vimeo developer account and get an API key.")
        }
        return key
    }

    /// Fetches a value for a given key from the 'Vimeo-Info.plist' file.
    ///
    /// - Parameter key: The key for which the value is sought.
    /// - Returns: The value associated with the given key.
    private func fetchValueFromPlist(forKey key: String) -> String {
        guard let filePath = Bundle.main.path(forResource: "Vimeo-Info", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let value = plist.object(forKey: key) as? String else {
            fatalError("Couldn't find key '\(key)' in 'Vimeo-Info.plist'.")
        }
        return value
    }

    /// Fetches folders located in the root folder of the Vimeo account.
    func fetchFoldersInRootFolder() async throws -> [Folder] {
        let urlString = "\(baseUrl)/users/\(userId)/projects/\(rootFolderId)/items"
        let response: RootFolderResponse = try await fetchData(urlString: urlString, responseType: RootFolderResponse.self)
        return response.data.map { $0.folder }
    }

    /// Fetches videos from a specified course folder on Vimeo.
    func fetchVideosInCourseFolder(from folderUrl: String) async throws -> [VideoItem] {
        let urlString = "\(baseUrl)\(folderUrl)/items"
        let response: VideosOfACourseResponse = try await fetchData(urlString: urlString, responseType: VideosOfACourseResponse.self)
        return response.data
    }

    /// Retrieves a link for a specified video.
    func getLink(for video: Video, withQuality quality: String, andRendition rendition: String) -> String? {
        guard let files = video.files else {
            return nil
        }
        return files.first { $0.quality == quality && $0.rendition == rendition }?.link
    }

    /// Fetches an image from a specified URL.
    func getImage(url: String) async throws -> UIImage? {
        guard let url = URL(string: baseUrl + url) else {
            fatalError("Invalid URL: \(baseUrl + url)")
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    }

    /// Performs a generic fetch data operation from the Vimeo API.
    ///
    /// - Parameters:
    ///   - urlString: The URL string for the request.
    ///   - responseType: The expected response type.
    /// - Returns: A decoded object of the specified response type.
    private func fetchData<T: Decodable>(urlString: String, responseType: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/vnd.vimeo.*+json;version=3.4", forHTTPHeaderField: "Accept")
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
