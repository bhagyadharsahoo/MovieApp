//
//  FavoritesManager.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//
import SwiftUI
import Combine

class FavoritesManager: ObservableObject {
    @Published var favoriteIds: Set<Int> = []
    private let storageKey = "movie_favorite_ids"
    
    init() {
        loadFavorites()
    }
    
    func toggleFavorite(_ movieId: Int) {
        if favoriteIds.contains(movieId) {
            favoriteIds.remove(movieId)
        } else {
            favoriteIds.insert(movieId)
        }
        saveFavorites()
        objectWillChange.send()  // Notify UI
    }
    
    func isFavorite(_ movieId: Int) -> Bool {
        favoriteIds.contains(movieId)
    }
    
    private func saveFavorites() {
        UserDefaults.standard.set(Array(favoriteIds), forKey: storageKey)
    }
    
    private func loadFavorites() {
        guard let saved = UserDefaults.standard.array(forKey: storageKey) as? [Int] else { return }
        favoriteIds = Set(saved)
    }
}
