import Foundation

@MainActor
class FavoriteVideosViewModel: ObservableObject {
    @Published var favoriteVideos: [Video] = []
    private let storageService: FavoritesStorageServiceProtocol

    init(storageService: FavoritesStorageServiceProtocol = FavoritesStorageService()) {
        self.storageService = storageService
        loadFavoriteVideos()
    }

    public func contains(_ video: Video) -> Bool {
        favoriteVideos.contains { $0.uri == video.uri }
    }

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

    func remove(_ video: Video) {
        objectWillChange.send()
        do {
            try storageService.remove(video)
            loadFavoriteVideos()
        } catch {
            print("Error removing video: \(error)")
        }
    }

    private func loadFavoriteVideos() {
        do {
            favoriteVideos = try storageService.loadFavoriteVideos()
        } catch {
            print("Error loading favorite videos: \(error)")
        }
    }
}
