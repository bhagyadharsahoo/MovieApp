//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//

import SwiftUI

@main
struct MoviesAppApp: App {
    @StateObject private var favoritesManager = FavoritesManager()
    var body: some Scene {
        WindowGroup {
                MovieListView()
                    .environmentObject(favoritesManager)
        }
    }
}
