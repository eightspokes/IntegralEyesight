//
//  VideoStorageService.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/29/23.
//

import Foundation
protocol FavoritesStorageServiceProtocol {
    func saveFavoriteVideos(_ videos: [Video]) throws
    func loadFavoriteVideos() throws -> [Video]
}
