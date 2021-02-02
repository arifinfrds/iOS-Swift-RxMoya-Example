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
    func fetchPhotos() -> Single<[Photo]>
}

final class DefaultPhotoDataService: PhotoDataService {
    private let provider: MoyaProvider<PhotoService>
    
    init(provider: MoyaProvider<PhotoService>) {
        self.provider = provider
    }
    
    enum Error: Swift.Error {
        case unauthorized
        case unknown
    }
    
    func fetchPhotos() -> Single<[Photo]> {
        return Single.create { single -> Disposable in
            return self.provider.rx.request(.fetchPhotos)
                .subscribe { response in
                    if response.statusCode == 200 {
                        do {
                            let photoResponseDTOs = try JSONDecoder().decode([PhotoResponseDTO].self, from: response.data)
                            let photoModels = photoResponseDTOs.map { $0.toModel() }
                            return single(.success(photoModels))
                        } catch {
                            return single(.error(error))
                        }
                    } else if response.statusCode == 401 {
                        return single(.error(Error.unauthorized))
                    } else {
                        return single(.error(Error.unknown))
                    }
                } onError: { error in
                    return single(.error(error))
                }
        }
    }
}
