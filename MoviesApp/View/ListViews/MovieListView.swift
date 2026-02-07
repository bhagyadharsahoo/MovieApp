//
//  MovieListView.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//

import SwiftUI
struct MovieListView: View {
    @StateObject var viewModel = ListViewmodel()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(Array(viewModel.popularData.enumerated()), id: \.offset) { index, movie in
                    NavigationLink(value: movie.id ?? 0) {
                        MovieRowView(movie: movie)
                    }
                    .onAppear {
                        if index == viewModel.popularData.count - 3 {
                            Task { await viewModel.loadNextPage() }
                        }
                    }

                }
                
                if viewModel.isLoadingMore {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .listStyle(.plain)
            .searchable(text: $viewModel.searchtext)
            .onChange(of: viewModel.searchtext) { newValue in
                Task {
                    try? await Task.sleep(nanoseconds: 500_000_000)
                    if !newValue.isEmpty {
                        await viewModel.searchMovies(query: newValue)
                    } else {
                        viewModel.isSearching = false
                        await viewModel.getPopularMoviesData(page: 1)
                    }
                }
            }
            .navigationDestination(for: Int.self) { movieId in
                MovieDetailView(movieId: movieId)
            }
            .task {
                await viewModel.getPopularMoviesData(page: 1)
            }
            .navigationTitle("Movies")
        }
    }
}


#Preview {
    MovieListView()
}
