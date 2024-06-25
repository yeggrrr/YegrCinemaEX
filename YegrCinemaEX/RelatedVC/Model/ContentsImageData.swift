//
//  ContentsImageData.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/25/24.
//

import Foundation

struct ContentsImageData: Codable {
    let page: Int
    let results: [ContentsResults]
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
    }
    
    struct ContentsResults: Codable {
        let posterPath: String?
        
        enum CodingKeys: String, CodingKey {
            case posterPath = "poster_path"
        }
    }
}
