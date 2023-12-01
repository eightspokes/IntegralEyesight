//
//  VimeoServiceService.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/29/23.
//

import Foundation
class FavoritesStorageService: FavoritesStorageServiceProtocol {
    private func getFavoritesFileURL() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("favoriteVideos.json")
    }
    
    func saveFavoriteVideos(_ videos: [Video]) throws {
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(videos)
        let fileURL = getFavoritesFileURL()
        try encoded.write(to: fileURL)
    }
    
    func loadFavoriteVideos() throws -> [Video] {
        let fileURL = getFavoritesFileURL()
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        return try decoder.decode([Video].self, from: data)
    }
}
