import Foundation

/// A mock implementation of `FavoritesStorageServiceProtocol` for testing purposes.
///
/// This class simulates the behavior of a favorites storage service. It provides mechanisms
/// to mock the saving, loading, adding, and removing of favorite videos without actual data persistence.
/// Additionally, it tracks if specific methods were called, aiding in verifying method calls during tests.
class MockFavoritesStorageService: FavoritesStorageServiceProtocol {
    /// An array representing the videos to be returned when `loadFavoriteVideos` is called.
    var videosToReturn: [Video] = []

    /// A flag to track whether `saveFavoriteVideos` was called.
    var saveWasCalled = false

    /// A flag to track whether `loadFavoriteVideos` was called.
    var loadWasCalled = false

    /// Mocks the saving of favorite videos.
    ///
    /// Instead of saving to an actual storage, it sets `saveWasCalled` to `true`.
    /// - Parameter videos: The array of `Video` objects to be 'saved'.
    func saveFavoriteVideos(_ videos: [Video]) throws {
        saveWasCalled = true
    }

    /// Mocks the loading of favorite videos.
    ///
    /// Returns `videosToReturn` and sets `loadWasCalled` to `true`.
    /// - Returns: An array of `Video` objects.
    func loadFavoriteVideos() throws -> [Video] {
        loadWasCalled = true
        return videosToReturn
    }

    /// Mocks the addition of a video to the favorites.
    ///
    /// Adds the video to `videosToReturn` if it's not already present.
    /// - Parameter video: The `Video` object to add.
    func add(_ video: Video) throws {
        if !videosToReturn.contains(where: { $0.uri == video.uri }) {
            videosToReturn.append(video)
        }
    }

    /// Mocks the removal of a video from the favorites.
    ///
    /// Removes the video from `videosToReturn`.
    /// - Parameter video: The `Video` object to remove.
    func remove(_ video: Video) throws {
        videosToReturn.removeAll { $0.uri == video.uri }
    }
}
