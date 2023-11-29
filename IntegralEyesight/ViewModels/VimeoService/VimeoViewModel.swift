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

    private var vimeoService: VimeoServiceProtocol

       @Published private(set) var foldersInRootFolder: [Folder] = []
       @Published private(set) var isFetchFoldersInRootLoading: Bool = true
       @Published private(set) var isFetchVideosInCourseLoading: Bool = true

       init(service: VimeoServiceProtocol) {
           self.vimeoService = service
       }

       func fetchFoldersInRootFolder() async throws {
           self.isFetchFoldersInRootLoading = true
           defer { self.isFetchFoldersInRootLoading = false }
           self.foldersInRootFolder = try await vimeoService.fetchFoldersInRootFolder()
       }

       func fetchVideosInCourseFolder(from folderUrl: String)  async throws -> [VideoItem]{
           self.isFetchVideosInCourseLoading = true
           defer { self.isFetchVideosInCourseLoading = false }
           return  try await vimeoService.fetchVideosInCourseFolder(from: folderUrl)

       }

       func getLink(for video: Video, withQuality quality: String, andRendition rendition: String) -> String? {
           return vimeoService.getLink(for: video, withQuality: quality, andRendition: rendition)
       }

       func getImage(url: String) async throws -> UIImage? {
           return try await vimeoService.getImage(url: url)
       }

}


