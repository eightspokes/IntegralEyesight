//
//  VimeoService.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/28/23.
//

import Foundation
import SwiftUI
final class VimeoService: VimeoServiceProtocol {
    private let baseUrl = "https://api.vimeo.com"

    var userId: String {
        return fetchValueFromPlist(forKey: "User_id")
    }

    var rootFolderId: String {
        return fetchValueFromPlist(forKey: "Root_folder_id")
    }

    var apiKey: String {
        let key = fetchValueFromPlist(forKey: "Api_key")
        if key.starts(with: "_") {
            fatalError("Register for a Vimeo developer account and get an API key.")
        }
        return key
    }

    private func fetchValueFromPlist(forKey key: String) -> String {
        guard let filePath = Bundle.main.path(forResource: "Vimeo-Info", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let value = plist.object(forKey: key) as? String else {
            fatalError("Couldn't find key '\(key)' in 'Vimeo-Info.plist'.")
        }
        return value
    }

    func fetchFoldersInRootFolder() async throws -> [Folder] {
        let urlString = "\(baseUrl)/users/\(userId)/projects/\(rootFolderId)/items"
        let response: RootFolderResponse = try await fetchData(urlString: urlString, responseType: RootFolderResponse.self)
        return response.data.map { $0.folder }
    }


    func fetchVideosInCourseFolder(from folderUrl: String) async throws -> [VideoItem] {
        let urlString = "\(baseUrl)\(folderUrl)/items"
            let response: VideosOfACourseResponse = try await fetchData(urlString: urlString, responseType: VideosOfACourseResponse.self)
            return response.data
    }

    func getLink(for video: Video, withQuality quality: String, andRendition rendition: String) -> String? {
        guard let files = video.files else {
            return nil
        }
        return files.first { $0.quality == quality && $0.rendition == rendition }?.link
    }

    func getImage(url: String) async throws -> UIImage? {
        guard let url = URL(string: baseUrl + url) else {
            fatalError("Invalid URL: \(baseUrl + url)")
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    }

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

