//
//  SimilarData.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/24/24.
//

import Foundation

struct SimilarData: Codable {
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
        let posterPath: String?
        let title: String
        
        enum CodingKeys: String, CodingKey {
            case posterPath = "poster_path"
            case title = "title"
        }
    }
}
