//
//  PopularDataModel.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//
import Foundation

// MARK: - UserDataModel
struct PopularDataModel: Codable {
    var page: Int?
    var results: [Result]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    // MARK: - Result
    struct Result: Codable, Identifiable {
        var adult: Bool?
        var backdropPath: String?
        var genreIDS: [Int]?
        var id: Int?
        var originalTitle, overview: String?
        var popularity: Double?
        var posterPath, releaseDate, title: String?
        var video: Bool?
        var voteAverage: Double?
        var voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
        
        var posterURL: URL? {
            guard let posterPath else { return nil }
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        }
        
        var durationText: String {
            guard let voteCount else { return "N/A" }
            return "\(voteCount) min"
        }
        
        var ratingText: String {
            String(format: "%.1f", voteAverage ?? 0.0)
        }

    }

}

