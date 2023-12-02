import Foundation

class MockFavoritesStorageService: FavoritesStorageServiceProtocol {
    var videosToReturn: [Video] = []
    var saveWasCalled = false
    var loadWasCalled = false
    
    func saveFavoriteVideos(_ videos: [Video]) throws {
        saveWasCalled = true
    }
    
    func loadFavoriteVideos() throws -> [Video] {
        loadWasCalled = true
        return videosToReturn
    }
    
    func add(_ video: Video) throws {
        if !videosToReturn.contains(where: { $0.uri == video.uri }) {
            videosToReturn.append(video)
        }
    }
    
    func remove(_ video: Video) throws {
        videosToReturn.removeAll { $0.uri == video.uri }
    }
}
