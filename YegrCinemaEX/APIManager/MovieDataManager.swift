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
 
    func getGenreData(completion: @escaping(GenreData) -> Void) {
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
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieData(completion: @escaping(MovieData) -> Void) {
        let url = APIURL.trendingMovieURL
        let header: HTTPHeaders = [
            "Authorization": APIKey.authorization,
            "accept": APIKey.accept
        ]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: MovieData.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCreditsData(id: Int, completion: @escaping (CreditData) -> Void) {
        let url = "\(APIURL.movieURL)\(id)/credits"
        guard let creditsURL = URL(string: url) else { return }
        
        let params: Parameters  =  [
            "api_key": APIKey.apiKey
        ]
        
        AF.request(creditsURL, method: .get, parameters: params).responseDecodable(of: CreditData.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
