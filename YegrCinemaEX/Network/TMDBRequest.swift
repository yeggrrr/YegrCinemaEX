//
//  TMDBRequest.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/26/24.
//

import Foundation
import Alamofire

enum TMDBRequest {
    case similar(id: Int)
    case recommend(id: Int)
    case poster(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self {
        case .similar(let id):
            return URL(string: baseURL + "movie/\(id)/similar")!
        case .recommend(let id):
            return URL(string: baseURL + "movie/\(id)/recommendations")!
        case .poster(let id):
            return URL(string: baseURL + "movie/\(id)/images")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.authorization,
                "accept": APIKey.accept]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        return ["api_key": APIKey.apiKey]
    }
}