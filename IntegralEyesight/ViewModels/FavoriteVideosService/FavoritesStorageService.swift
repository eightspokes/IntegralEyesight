import Foundation

/// A service class for managing the storage of favorite videos.
///
/// This class implements the `FavoritesStorageServiceProtocol` and provides functionalities
/// to save, load, add, and remove favorite videos. It uses the local file system for storage,
/// specifically storing data in JSON format.
class FavoritesStorageService: FavoritesStorageServiceProtocol {

    /// Retrieves the URL for the favorites file in the documents directory.
    ///
    /// - Returns: A `URL` pointing to the `favoriteVideos.json` file in the user's document directory.
    private func getFavoritesFileURL() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("favoriteVideos.json")
    }

    /// Saves a list of favorite videos to a file in JSON format.
    ///
    /// - Parameter videos: The array of `Video` objects to be saved.
    /// - Throws: An error if the saving process fails.
    func saveFavoriteVideos(_ videos: [Video]) throws {
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(videos)
        let fileURL = getFavoritesFileURL()
        try encoded.write(to: fileURL)
    }

    /// Loads the list of favorite videos from a file in JSON format.
    ///
    /// - Returns: An array of `Video` objects.
    /// - Throws: An error if the loading process fails.
    func loadFavoriteVideos() throws -> [Video] {
        let fileURL = getFavoritesFileURL()
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        return try decoder.decode([Video].self, from: data)
    }

    /// Adds a single video to the list of favorites.
    ///
    /// This method first loads the current list of favorites, then adds the new video if it's not already present,
    /// and finally saves the updated list back to the file.
    /// - Parameter video: The `Video` object to add.
    /// - Throws: An error if the adding process fails.
    func add(_ video: Video) throws {
        var videos = try loadFavoriteVideos()
        if !videos.contains(where: { $0.uri == video.uri }) {
            videos.append(video)
            try saveFavoriteVideos(videos)
        }
    }

    /// Removes a single video from the list of favorites.
    ///
    /// This method first loads the current list of favorites, removes the specified video, and then saves
    /// the updated list back to the file.
    /// - Parameter video: The `Video` object to remove.
    /// - Throws: An error if the removal process fails.
    func remove(_ video: Video) throws {
        var videos = try loadFavoriteVideos()
        videos.removeAll { $0.uri == video.uri }
        try saveFavoriteVideos(videos)
    }
}
