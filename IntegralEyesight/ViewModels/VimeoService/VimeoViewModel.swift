//
//  VimeoViewModel.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/24/23.
//

import Foundation
import SwiftUI

@MainActor
final class VimeoViewModel: ObservableObject{

    private let baseUrl = "https://api.vimeo.com"

    @Published private(set) var foldersInRootFolder: [Folder] = []
    @Published private(set) var isFetchFoldersInRootLoading: Bool = true
    @Published private(set) var isFetchVideosInCourseLoading: Bool = true

    public var rootFolderId: String {
        get {
            // 1
            guard let filePath = Bundle.main.path(forResource: "Vimeo-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'Vimeo-Info.plist'.")
            }
            // 2
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "Root_folder_id") as? String else {
                fatalError("Couldn't find key 'Root_folder_id' in 'Vimeo-Info.plist'.")
            }
            return value
        }
    }

    public var userId: String {
        get {
            // 1
            guard let filePath = Bundle.main.path(forResource: "Vimeo-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'Vimeo-Info.plist'.")
            }
            // 2
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "User_id") as? String else {
                fatalError("Couldn't find key 'User_id' in 'Vimeo-Info.plist'.")
            }
            return value
        }
    }


    public var apiKey: String {
        get {

            guard let filePath = Bundle.main.path(forResource: "Vimeo-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'Vimeo-Info.plist'.")
            }

            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "Api_key") as? String else {
                fatalError("Couldn't find key 'Api_key' in 'Vimeo-Info.plist'.")
            }

            if (value.starts(with: "_")) {
                fatalError("Register for a Vimeo developer account and get an API key")
            }
            return value
        }

    }

    func fetchFoldersInRootFolder() async throws {
        self.isFetchFoldersInRootLoading = true
        defer {self.isFetchFoldersInRootLoading = false}

        let fetchAllItemsInRootFolderUrlString = "\(baseUrl)/users/\(userId)/projects/\(rootFolderId)/items"
        guard let url = URL(string: fetchAllItemsInRootFolderUrlString) else {
            fatalError("Invalid URL: \(fetchAllItemsInRootFolderUrlString)")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Set the headers as per Vimeo's requirements
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/vnd.vimeo.*+json;version=3.4", forHTTPHeaderField: "Accept")

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        print(String(data: data, encoding: .utf8) ?? "Invalid JSON")
        let response = try decoder.decode(RootFolderResponse.self, from: data)
        self.foldersInRootFolder = response.data.map{$0.folder}
    }

    func fetchVideosInCourseFolder(from folderUrl: String) async throws -> [VideoItem]{
        // folderUrl is expected in format: users/47826142/projects/18611365
        // baseUrl = "https://api.vimeo.com"

        self.isFetchVideosInCourseLoading = true
        defer {self.isFetchVideosInCourseLoading = false}

        let fetchVideosInCourseFolderUrlString = "\(baseUrl)\(folderUrl)/items"
        print("!!!! This is url string I am calling\(fetchVideosInCourseFolderUrlString)")
        guard let url = URL(string: fetchVideosInCourseFolderUrlString) else {
            fatalError("Invalid URL: \(fetchVideosInCourseFolderUrlString)")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Set the headers as per Vimeo's requirements
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/vnd.vimeo.*+json;version=3.4", forHTTPHeaderField: "Accept")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        // print("Data Received: \(String(describing: String(data: data, encoding: .utf8)))")


        let response = try decoder.decode(VideosOfACourseResponse.self, from: data)

        return response.data
    }

    //This will get link of mp4 file
    func getLink(for video: Video, withQuality quality: String, andRendition rendition: String) -> String? {
        // Check if the video has any files
        guard let files = video.files else {
            return nil
        }

        // Search for the file that matches the given quality and rendition
        for file in files {
            if file.quality == quality && file.rendition == rendition {
                return file.link
            }
        }
        // Return nil if no matching file is found
        return nil
    }


    func getImage(url: String) async throws -> UIImage? {
        guard let url = URL(string: baseUrl + url) else {
            fatalError("Missing URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Set the headers as per Vimeo's requirements
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/vnd.vimeo.*+json;version=3.4", forHTTPHeaderField: "Accept")

        let (data, _) = try await URLSession.shared.data(for: request)
        return UIImage(data: data)
    }
}


