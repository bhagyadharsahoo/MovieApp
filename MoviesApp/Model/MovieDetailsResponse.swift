//
//  MovieDetailsResponse.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//
import Foundation

// MARK: - UserDataModel
struct MovieDetailsResponse: Codable, Identifiable {
    var adult: Bool?
    var backdropPath: String?
    var budget: Int?
    var genres: [Genre]?
    var homepage: String?
    var id: Int?
    var imdbID: String?
    var originCountry: [String]?
    var originalLanguage, originalTitle, overview: String?
    var popularity: Double?
    var posterPath, releaseDate: String?
    var revenue, runtime: Int?
    var spokenLanguages: [SpokenLanguage]?
    var status, tagline, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    let credits: CreditsResponse

    enum CodingKeys: String, CodingKey {
        case adult
        case credits
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct CreditsResponse: Codable {
    let cast: [CastMember]
}

struct CastMember: Codable, Identifiable {
    let id: Int
    let name: String
}

// MARK: - Genre
struct Genre: Codable {
    var id: Int?
    var name: String?
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    var englishName, iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}

import Foundation
//
//struct MovieDetailsResponse: Decodable {
//    let title: String
//    let overview: String
//    let runtime: Int?  // minutes
//    let voteAverage: Double
//    let genres: [Genre]
//    let videos: VideoResponse
//    let credits: CreditsResponse?
//}
//
//struct Genre: Identifiable, Decodable {
//    let id: Int
//    let name: String
//}
//
//struct VideoResponse: Decodable {
//    let results: [Video]
//}
//
//struct Video: Decodable {
//    let key: String  // YouTube key
//    let type: String  // "Trailer"
//    let site: String  // "YouTube"
//    
//    var youtubeURL: URL? {
//        URL(string: "https://www.youtube.com/watch?v=\(key)")
//    }
//}
//
//struct CreditsResponse: Decodable {
//    let cast: [CastMember]
//}
//
//struct CastMember: Decodable,Identifiable {
//    var id = UUID()
//    let name: String
//    let profilePath: String?
//}
