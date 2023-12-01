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
    func add(_ video: Video) throws
    func remove(_ video: Video) throws
}
