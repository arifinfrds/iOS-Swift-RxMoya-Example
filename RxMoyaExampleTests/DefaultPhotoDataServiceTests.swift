//
//  DefaultPhotoDataServiceTests.swift
//  DefaultPhotoDataServiceTests
//
//  Created by Arifin Firdaus on 26/01/21.
//

import XCTest
import Moya
import RxBlocking
@testable import RxMoyaExample

class DefaultPhotoDataServiceTests: XCTestCase {
    
    func test_fetchPhotos_deliverPhotos() {
        let sut = makeSUT()
                
        guard let capturedPhotos = try! sut.fetchPhotos().toBlocking().first() else {
            XCTFail("expect photos but got nil instead")
            return
        }
        
        XCTAssertTrue(!capturedPhotos.isEmpty)
    }
    
    private func makeSUT() -> DefaultPhotoDataService {
        let provider = MoyaProvider<PhotoService>()
        return DefaultPhotoDataService(provider: provider)
    }
    
}
