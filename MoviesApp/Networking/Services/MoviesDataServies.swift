//
//  MoviesDataServies.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//
import Foundation
protocol ListpageActionable {
   func getPopularMoviesData(page: Int) async throws -> PopularDataModel
   func searchMovies(query: String) async throws -> PopularDataModel
}

protocol DetailPageActionable {
    func getMovieVideos(movieId: Int) async throws -> VidioDataModel
    func getMovieDetails(movieId: Int) async throws -> MovieDetailsResponse
}

final class MoviesDataServies: ListpageActionable, DetailPageActionable{
    
    let networkClient: NetworkClient
    
    init() {
        self.networkClient = URLSessionNetworkClient()
    }
    
    func getPopularMoviesData(page: Int) async throws -> PopularDataModel {
           let endpoint = PopularMoviesEndpoint(page: page)
           return try await networkClient.send(endpoint)
       }
    
    func getMovieDetails(movieId: Int) async throws -> MovieDetailsResponse {
        let endpoint = MovieDetailsEndpoint(movieId: movieId)
        return try await networkClient.send(endpoint)
    }

    func searchMovies(query: String) async throws -> PopularDataModel {
        let endpoint = SearchMoviesEndpoint(query: query)
        return try await networkClient.send(endpoint)
    }
    
    func getMovieVideos(movieId: Int) async throws -> VidioDataModel {
        let endpoint = MovieVideosEndpoint(movieId: movieId)
        return try await networkClient.send(endpoint)
    }

}

