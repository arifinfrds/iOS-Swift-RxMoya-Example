//
//  PhotoResponseDTO.swift
//  RxMoyaExample
//
//  Created by Arifin Firdaus on 26/01/21.
//

import Foundation

struct PhotoResponseDTO: Codable {
    let albumID: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailURL = "thumbnailUrl"
    }
}

extension PhotoResponseDTO {
    
    func toModel() -> Photo {
        return Photo(albumID: albumID, id: id, title: title, url: url, thumbnailURL: thumbnailURL)
    }
    
}

struct Photo {
    let albumID: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailURL: String
}
