//
//  SearchData.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/12/24.
//

import Foundation

struct SearchMovie: Codable {
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
        let backdropPath: String?
        let genreIds: [Int]
        let id: Int
        let overview: String
        let posterPath: String?
        let releaseDate: String
        let title: String
        
        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case genreIds = "genre_ids"
            case id = "id"
            case overview = "overview"
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title = "title"
        }
    }
}
