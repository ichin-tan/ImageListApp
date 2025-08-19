//
//  ApiManager.swift
//  ImageListApp
//
//  Created by CP on 19/08/25.
//

import Foundation
import Alamofire

class ApiManager {
    
    //MARK: - Properties -
    
    static let shared = ApiManager()
    
    //MARK: - Methods -
    
    func fetchPhotosAPI(completion: @escaping (Result<[PhotoItem], Error>) -> ()) {
        AF.request(APIURL)
            .validate()
            .responseDecodable(of: [PhotoItem].self,completionHandler: { response in
                switch response.result {
                case .success(let arrPhotos):
                    completion(.success(arrPhotos))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
    }
}
