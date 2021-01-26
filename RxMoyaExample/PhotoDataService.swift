//
//  PhotoDataService.swift
//  RxMoyaExample
//
//  Created by Arifin Firdaus on 26/01/21.
//

import Foundation
import Moya

typealias FetchPhotosResult = (Result<[Photo], Error>) -> Void

protocol PhotoDataService {
    func fetchPhotos(completion: @escaping FetchPhotosResult)
}

final class DefaultPhotoDataService: PhotoDataService {
    private let provider: MoyaProvider<PhotoService>
    
    init(provider: MoyaProvider<PhotoService>) {
        self.provider = provider
    }
    
    func fetchPhotos(completion: @escaping FetchPhotosResult) {
        provider.request(.fetchPhotos) { result in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let photos = try JSONDecoder().decode([Photo].self, from: filteredResponse.data)
                    completion(.success(photos))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
