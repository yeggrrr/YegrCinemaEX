//
//  MovieData.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/10/24.
//

import Foundation

struct MovieData: Codable {
    let page: Int
    let results: [Results]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    struct Results: Codable {
        let id: Int
        let backdropPath: String
        let overview: String
        let posterPath: String
        let mediaType: String
        let title: String
        let genreIds: [Int]
        let releaseDate: String
        let voteAverage: Double
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case backdropPath = "backdrop_path"
            case overview = "overview"
            case posterPath = "poster_path"
            case mediaType = "media_type"
            case title = "title"
            case genreIds = "genre_ids"
            case releaseDate = "release_date"
            case voteAverage = "vote_average"
        }
    }
}

struct CreditData: Decodable {
    let cast: [Cast]
    
    struct Cast: Codable {
        let profilePath: String?
        let name: String
        let character: String
        
        enum CodingKeys: String, CodingKey {
            case profilePath = "profile_path"
            case name = "name"
            case character = "character"
        }
    }
}

struct GenreData: Decodable {
    var genres: [Genre]
    
    struct Genre: Decodable {
        let id: Int
        let name: String
    }
}
