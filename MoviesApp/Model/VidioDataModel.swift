//
//  UserDataModel.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//

import Foundation

// MARK: - UserDataModel
struct VidioDataModel: Codable {
    var id: Int?
    var results: [Result]?
    
    // MARK: - Result
    struct Result: Codable, Identifiable {
        // Keep the raw API id separate to avoid conflicts with Identifiable
        var videoID: String?
        var iso639_1, iso3166_1, name, key: String?
        var site: String?
        var size: Int?
        var type: String?
        var official: Bool?
        var publishedAt: String?
        
        // Use the API videoID as Identifiable's id
        var id: String { videoID ?? UUID().uuidString }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            iso639_1 = try container.decodeIfPresent(String.self, forKey: .iso639_1)
            iso3166_1 = try container.decodeIfPresent(String.self, forKey: .iso3166_1)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            key = try container.decodeIfPresent(String.self, forKey: .key)
            site = try container.decodeIfPresent(String.self, forKey: .site)
            size = try container.decodeIfPresent(Int.self, forKey: .size)
            type = try container.decodeIfPresent(String.self, forKey: .type)
            official = try container.decodeIfPresent(Bool.self, forKey: .official)
            publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
            videoID = try container.decodeIfPresent(String.self, forKey: .videoID)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(iso639_1, forKey: .iso639_1)
            try container.encodeIfPresent(iso3166_1, forKey: .iso3166_1)
            try container.encodeIfPresent(name, forKey: .name)
            try container.encodeIfPresent(key, forKey: .key)
            try container.encodeIfPresent(site, forKey: .site)
            try container.encodeIfPresent(size, forKey: .size)
            try container.encodeIfPresent(type, forKey: .type)
            try container.encodeIfPresent(official, forKey: .official)
            try container.encodeIfPresent(publishedAt, forKey: .publishedAt)
            try container.encodeIfPresent(videoID, forKey: .videoID)
        }

        enum CodingKeys: String, CodingKey {
            case iso639_1 = "iso_639_1"
            case iso3166_1 = "iso_3166_1"
            case name, key, site, size, type, official
            case publishedAt = "published_at"
            case videoID = "id"
        }
        
        var thumbnailURL: URL? {
            URL(string: "https://img.youtube.com/vi/\(key ?? "")/maxresdefault.jpg")
        }
        
        var displayType: String {
            switch type {
            case "Trailer": return "Trailer"
            case "Clip": return "Clip"
            default:
                return type?.capitalized ?? ""
            }
        }
    }

}
