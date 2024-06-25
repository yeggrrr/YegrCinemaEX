//
//  ContentsAPIManager.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/25/24.
//

import Foundation
import Alamofire

func getContentsData(id: Int, completion: @escaping ([ContentsImageData.ContentsResults]) -> Void) {
    let url = APIURL.contentsURL + "\(id)/similar"
    guard let similarURL = URL(string: url) else { return }
    
    let header: HTTPHeaders = [
        "Authorization": APIKey.authorization,
        "accept": APIKey.accept
    ]
    
    let params: Parameters  =  [
        "api_key": APIKey.apiKey
    ]
    
    AF.request(similarURL, method: .get, parameters: params, headers: header).responseDecodable(of: ContentsImageData.self) { response in
        switch response.result {
        case .success(let value):
            completion(value.results)
        case .failure(let error):
            print(error)
        }
    }
}
