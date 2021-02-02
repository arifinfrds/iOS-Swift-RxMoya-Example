//
//  PhotoService.swift
//  RxMoyaExample
//
//  Created by Arifin Firdaus on 26/01/21.
//

import Foundation
import Moya

enum PhotoService: TargetType {
    case fetchPhotos
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .fetchPhotos:
            return "/photos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .fetchPhotos:
            let photo: [String: Any] = [
                "albumId": 1,
                "id": 1,
                "title": "accusamus beatae ad facilis cum similique qui sunt",
                "url": "https://via.placeholder.com/600/92c952",
                "thumbnailUrl": "https://via.placeholder.com/150/92c952"
            ]
            let photos = [photo]
            do {
                let data = try JSONSerialization.data(withJSONObject: photos, options: .prettyPrinted)
                return data
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}


extension PhotoService {
    
    var unauhtorizedSampleData: Data {
        switch self {
        case .fetchPhotos:
            let serverResponse: [String: Any] = [
                "message": "invalid credentials"
            ]
            do {
                let data = try JSONSerialization.data(withJSONObject: serverResponse, options: .prettyPrinted)
                return data
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
