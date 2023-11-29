//
//  VimeoServiceProtocol.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/28/23.
//

import Foundation
import SwiftUI
protocol VimeoServiceProtocol {
    func fetchFoldersInRootFolder() async throws -> [Folder]
    func fetchVideosInCourseFolder(from folderUrl: String) async throws -> [VideoItem]
    func getLink(for video: Video, withQuality quality: String, andRendition rendition: String) -> String?
    func getImage(url: String) async throws -> UIImage?
    var userId: String { get }
    var rootFolderId: String { get }
    var apiKey: String { get }
}
