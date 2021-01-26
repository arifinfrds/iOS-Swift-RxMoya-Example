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
        
        let exp = expectation(description: "Wait for completion")
        
        var capturedPhotos = [Photo]()
        _ = sut.fetchPhotos().subscribe { photos in
            capturedPhotos = photos
            exp.fulfill()
        } onError: { error in
            XCTFail("Expect success but got error instead, error: \(error)")
        }
        wait(for: [exp], timeout: 5.0)
        
        XCTAssertTrue(!capturedPhotos.isEmpty)
    }
    
    private func makeSUT() -> DefaultPhotoDataService {
        let provider = MoyaProvider<PhotoService>()
        return DefaultPhotoDataService(provider: provider)
    }
    
}
