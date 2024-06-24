//
//  PosterImageData.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/24/24.
//

import Foundation

struct PosterImageData: Codable {
    let backdrops: [Backdrops]
    
    struct Backdrops: Codable {
        let filePath: String
        
        enum CodingKeys: String, CodingKey {
            case filePath = "file_path"
        }
    }
}
