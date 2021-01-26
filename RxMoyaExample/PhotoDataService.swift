//
//  PhotoDataService.swift
//  RxMoyaExample
//
//  Created by Arifin Firdaus on 26/01/21.
//

import Foundation
import Moya
import RxSwift

protocol PhotoDataService {
    func fetchPhotos() -> Single<[PhotoResponseDTO]>
}

final class DefaultPhotoDataService: PhotoDataService {
    private let provider: MoyaProvider<PhotoService>
    
    init(provider: MoyaProvider<PhotoService>) {
        self.provider = provider
    }
    
    func fetchPhotos() -> Single<[PhotoResponseDTO]> {
        return provider.rx.request(.fetchPhotos)
            .map([PhotoResponseDTO].self)
    }
}
