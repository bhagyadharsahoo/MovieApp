//
//  MovieDetailsEndpoint.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//

import Foundation


struct MovieDetailsEndpoint: Endpoint {
    typealias Response = MovieDetailsResponse
    let movieId: Int

    let baseURL = URL(string: "https://api.themoviedb.org/3")!

    var path: String { "/movie/\(movieId)" }

    var method: HTTPMethod = .get

    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "api_key", value: "da195dbb474f3412bbf3515b0011717b"),
            URLQueryItem(name: "append_to_response", value: "credits")
        ]
    }
}
