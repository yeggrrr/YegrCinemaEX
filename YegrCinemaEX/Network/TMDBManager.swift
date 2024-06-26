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

    func getGenreData(api: TMDBRequest, completion: @escaping(GenreData) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, headers: api.header).responseDecodable(of: GenreData.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieData(api: TMDBRequest, completion: @escaping(MovieData) -> Void) {
        AF.request(api.endpoint, method: api.method, headers: api.header).responseDecodable(of: MovieData.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCreditsData(api: TMDBRequest, completion: @escaping (CreditData) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter).responseDecodable(of: CreditData.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSimilar(api: TMDBRequest, completion: @escaping ([ContentsImageData.ContentsResults]) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, headers: api.header).responseDecodable(of: ContentsImageData.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRecommend(api: TMDBRequest, completion: @escaping ([ContentsImageData.ContentsResults]) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, headers: api.header).responseDecodable(of: ContentsImageData.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPosterImage(api: TMDBRequest, completion: @escaping ([MoviePosterData.Backdrops]) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, headers: api.header).responseDecodable(of: MoviePosterData.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.backdrops)
            case .failure(let error):
                print(error)
            }
        }
    }
}
