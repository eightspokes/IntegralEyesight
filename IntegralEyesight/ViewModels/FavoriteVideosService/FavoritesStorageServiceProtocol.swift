import Foundation

/// Defines the required functionalities for a service managing the storage of favorite videos.
///
/// This protocol allows for different implementations of how favorite videos are saved, loaded, added, and removed.
/// Adhering to this protocol enables flexibility and easier testing by abstracting the storage details.
protocol FavoritesStorageServiceProtocol {
    /// Saves a list of favorite videos to persistent storage.
    ///
    /// - Parameter videos: The array of `Video` objects to be saved.
    /// - Throws: An error if the saving process fails.
    func saveFavoriteVideos(_ videos: [Video]) throws

    /// Loads the list of favorite videos from persistent storage.
    ///
    /// - Returns: An array of `Video` objects.
    /// - Throws: An error if the loading process fails.
    func loadFavoriteVideos() throws -> [Video]

    /// Adds a single video to the list of favorites in persistent storage.
    ///
    /// - Parameter video: The `Video` object to add.
    /// - Throws: An error if the adding process fails.
    func add(_ video: Video) throws

    /// Removes a single video from the list of favorites in persistent storage.
    ///
    /// - Parameter video: The `Video` object to remove.
    /// - Throws: An error if the removal process fails.
    func remove(_ video: Video) throws
}
