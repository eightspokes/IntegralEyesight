import Foundation
@MainActor
class FavoriteVideosViewModel: ObservableObject {
    @Published var favoriteVideos: [Video] = []

    init() {
        loadFavoriteVideos()
    }

    func contains(_ video: Video) -> Bool {
        return favoriteVideos.contains(where: { $0.uri == video.uri })
    }

    func add(_ video: Video) {
        objectWillChange.send()
        if !contains(video) {
            favoriteVideos.append(video)
            saveFavoriteVideos()
        }
    }

    func remove(_ video: Video) {
        objectWillChange.send()
        favoriteVideos.removeAll { $0.uri == video.uri }
        saveFavoriteVideos()
    }

    private func saveFavoriteVideos() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favoriteVideos) {
            let fileURL = getFavoritesFileURL()
            try? encoded.write(to: fileURL)
        }
    }

    private func loadFavoriteVideos() {
        let fileURL = getFavoritesFileURL()
        if let data = try? Data(contentsOf: fileURL) {
            let decoder = JSONDecoder()
            if let loadedVideos = try? decoder.decode([Video].self, from: data) {
                favoriteVideos = loadedVideos
            }
        }
    }

    private func getFavoritesFileURL() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("favoriteVideos.json")
    }
}
