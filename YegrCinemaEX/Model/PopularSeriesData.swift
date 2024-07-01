//
//  PopularSeriesData.swift
//  YegrCinemaEX
//
//  Created by YJ on 7/1/24.
//

import Foundation

struct PopularSeriesList: Decodable {
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
    
    struct Results: Decodable {
        let id: Int
        let overview: String
        let posterPath: String
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case id =  "id"
            case overview =  "overview"
            case posterPath =  "poster_path"
            case name =  "name"
        }
    }
}
