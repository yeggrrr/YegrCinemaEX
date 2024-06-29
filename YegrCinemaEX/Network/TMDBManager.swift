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
    
    func callRequest<T: Decodable>(api: TMDBRequest, model: T.Type, completion: @escaping(T?) -> Void, errorHandler: @escaping (String) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                errorHandler("\(T.self)의 정보를 가져오지 못했습니다.")
                print(error)
            }
        }
    }
    
    func getSimilar(api: TMDBRequest, completion: @escaping ([ContentsImageData.ContentsResults]) -> Void, errorHandler: @escaping (String) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, headers: api.header).responseDecodable(of: ContentsImageData.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.results)
            case .failure(let error):
                errorHandler(error.localizedDescription)
                print(error)
            }
        }
    }
    
    func getRecommend(api: TMDBRequest, completion: @escaping ([ContentsImageData.ContentsResults]) -> Void, errorHandler: @escaping (String) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, headers: api.header).responseDecodable(of: ContentsImageData.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.results)
            case .failure(let error):
                errorHandler(error.localizedDescription)
                print(error)
            }
        }
    }
    
    func getPosterImage(api: TMDBRequest, completion: @escaping ([MoviePosterData.Backdrops]?, String?) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, headers: api.header).responseDecodable(of: MoviePosterData.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.backdrops, nil)
            case .failure(let error):
                completion(nil, "잠시 후 다시 시도해주세요.")
                print(error)
            }
        }
    }
}
