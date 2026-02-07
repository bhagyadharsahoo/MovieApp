//
//  ListViewModel.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//
import Foundation
import Combine

final class ListViewmodel: ObservableObject {
    @Published var popularData: [PopularDataModel.Result] = []
    @Published var isLoading = false
    @Published var isLoadingMore = false
    @Published var currentPage = 0
    @Published var hasMorePages = true
    @Published var searchtext: String = ""
    
    @Published var isSearching = false
    private var isInitialLoad = true

    let listpageservice: ListpageActionable
    
    init() {
        self.listpageservice = MoviesDataServies()
    }

    func getPopularMoviesData(page: Int) async {
        guard !isSearching else {return}
        guard !isLoading && !isLoadingMore else { return }
        
        isLoading = isInitialLoad
        isLoadingMore = !isInitialLoad
        isInitialLoad = false
        
        currentPage = page
        do {
            let newData = try await listpageservice.getPopularMoviesData(page: page)
            await MainActor.run {
                if page == 1 {
                    popularData = newData.results ?? []
                } else {
                    popularData.append(contentsOf: newData.results ?? [])
                }
                hasMorePages = !(newData.results?.isEmpty ?? false)
                isSearching = false  // Back to popular mode
            }
        } catch {
            print("Popular movies error: \(error)")
        }
        await MainActor.run {
            isLoading = false
            isLoadingMore = false
        }
    }

    func searchMovies(query: String, page: Int = 1) async {
        guard !query.isEmpty, !isLoading && !isLoadingMore else { return }
        
        isLoading = page == 1
        isLoadingMore = page > 1
        
        currentPage = page
        do {
            let newData = try await listpageservice.searchMovies(query: query)
            await MainActor.run {
                if page == 1 {
                    popularData = newData.results ?? []  // Replace with search results
                } else {
                    popularData.append(contentsOf: newData.results ?? [])
                }
                hasMorePages = !(newData.results?.isEmpty ?? false)
                isSearching = true
            }
        } catch {
            print("Search error: \(error)")
        }
        await MainActor.run {
            isLoading = false
            isLoadingMore = false
        }
    }

    func loadNextPage() async {
        guard hasMorePages && !popularData.isEmpty else { return }
        
        if isSearching {
            await searchMovies(query: searchtext, page: currentPage + 1)
        } else {
            await getPopularMoviesData(page: currentPage + 1)
        }
    }
    
}

