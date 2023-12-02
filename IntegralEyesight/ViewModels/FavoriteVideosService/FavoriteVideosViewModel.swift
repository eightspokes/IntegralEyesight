import Foundation

/// A view model for managing a user's favorite videos.
///
/// This class is responsible for interacting with a storage service to load, add, and remove favorite videos.
/// It uses the `FavoritesStorageServiceProtocol` for data persistence, allowing for flexibility in the storage implementation.
@MainActor
class FavoriteVideosViewModel: ObservableObject {
    /// The list of favorite videos, observed by the view for updates.
    @Published var favoriteVideos: [Video] = []
    private let storageService: FavoritesStorageServiceProtocol

    /// Initializes the view model with a storage service.
    ///
    /// - Parameter storageService: The storage service used for saving and retrieving favorite videos.
    ///   Defaults to `FavoritesStorageService` if not provided.
    init(storageService: FavoritesStorageServiceProtocol = FavoritesStorageService()) {
        self.storageService = storageService
        loadFavoriteVideos()
    }

    /// Checks if a video is already marked as favorite.
    ///
    /// - Parameter video: The video to check.
    /// - Returns: `true` if the video is in the list of favorites; otherwise, `false`.
    public func contains(_ video: Video) -> Bool {
        favoriteVideos.contains { $0.uri == video.uri }
    }

    /// Adds a video to the list of favorites.
    ///
    /// If the video is not already in the list, it is added and persisted using the storage service.
    /// - Parameter video: The video to add to the favorites.
    func add(_ video: Video) {
        objectWillChange.send()
        if !contains(video) {
            do {
                try storageService.add(video)
                loadFavoriteVideos()
            } catch {
                print("Error adding video: \(error)")
            }
        }
    }

    /// Removes a video from the list of favorites.
    ///
    /// The video is removed from the list and the change is persisted using the storage service.
    /// - Parameter video: The video to remove from the favorites.
    func remove(_ video: Video) {
        objectWillChange.send()
        do {
            try storageService.remove(video)
            loadFavoriteVideos()
        } catch {
            print("Error removing video: \(error)")
        }
    }

    /// Loads the list of favorite videos from the storage service.
    ///
    /// This method is called during initialization and after any changes to the favorites.
    private func loadFavoriteVideos() {
        do {
            favoriteVideos = try storageService.loadFavoriteVideos()
        } catch {
            print("Error loading favorite videos: \(error)")
        }
    }
}
