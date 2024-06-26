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
    
    func getSimilarData(id: Int, completion: @escaping (SimilarData) -> Void) {
        let url = APIURL.contentsURL + "\(id)/similar"
        guard let similarURL = URL(string: url) else { return }
        
        let header: HTTPHeaders = [
            "Authorization": APIKey.authorization,
            "accept": APIKey.accept
        ]
        
        let params: Parameters  =  [
            "api_key": APIKey.apiKey
        ]
        
        AF.request(similarURL, method: .get, parameters: params, headers: header).responseDecodable(of: SimilarData.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRecommendData(id: Int, completion: @escaping (RecommendData) -> Void) {
        let url = APIURL.contentsURL + "\(id)/recommendations"
        guard let similarURL = URL(string: url) else { return }
        
        let header: HTTPHeaders = [
            "Authorization": APIKey.authorization,
            "accept": APIKey.accept
        ]
        
        let params: Parameters  =  [
            "api_key": APIKey.apiKey
        ]
        
        AF.request(similarURL, method: .get, parameters: params, headers: header).responseDecodable(of: RecommendData.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPosterData(id: Int, completion: @escaping (PosterImageData) -> Void) {
        let url = APIURL.contentsURL + "\(id)/images"
        guard let similarURL = URL(string: url) else { return }
        
        let header: HTTPHeaders = [
            "Authorization": APIKey.authorization,
            "accept": APIKey.accept
        ]
        
        let params: Parameters  =  [
            "api_key": APIKey.apiKey
        ]
        
        AF.request(similarURL, method: .get, parameters: params, headers: header).responseDecodable(of: PosterImageData.self) { response in
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
