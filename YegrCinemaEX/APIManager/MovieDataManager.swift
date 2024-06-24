//
//  MovieDataManager.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/24/24.
//

import Foundation
import Alamofire

class APICall {
    static let shared = APICall()
 
    func getGenreData(completionHandler: @escaping(GenreData) -> Void) {
        let url = APIURL.genreMovieListURL
        let header: HTTPHeaders = [
            "Authorization": APIKey.authorization,
            "accept": APIKey.accept
        ]
        
        let params: Parameters  =  [
            "api_key": APIKey.apiKey
        ]
        
        AF.request(url, method: .get, parameters: params, headers: header).responseDecodable(of: GenreData.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieData(completionHandler: @escaping(MovieData) -> Void) {
        let url = APIURL.trendingMovieURL
        let header: HTTPHeaders = [
            "Authorization": APIKey.authorization,
            "accept": APIKey.accept
        ]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: MovieData.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
