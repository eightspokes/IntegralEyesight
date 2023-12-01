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

    func add(_ video: Video) throws {
        var videos = try loadFavoriteVideos()
        if !videos.contains(where: { $0.uri == video.uri }) {
            videos.append(video)
            try saveFavoriteVideos(videos)
        }
    }

    func remove(_ video: Video) throws {
        var videos = try loadFavoriteVideos()
        videos.removeAll { $0.uri == video.uri }
        try saveFavoriteVideos(videos)
    }
}
