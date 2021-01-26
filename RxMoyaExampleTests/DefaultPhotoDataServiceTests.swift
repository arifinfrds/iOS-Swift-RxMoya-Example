//
//  DefaultPhotoDataServiceTests.swift
//  DefaultPhotoDataServiceTests
//
//  Created by Arifin Firdaus on 26/01/21.
//

import XCTest
import Moya
@testable import RxMoyaExample

class DefaultPhotoDataServiceTests: XCTestCase {
    
    func test_fetchPhotos_deliverPhotos() {
        let sut = makeSUT()
        
        let exp = expectation(description: "Wait for completion")
        
        var capturedPhotos = [Photo]()
        sut.fetchPhotos { result in
            switch result {
            case .success(let photos):
                capturedPhotos = photos
                exp.fulfill()
            case .failure(let error):
                XCTFail("Expect success but got error instead, error: \(error)")
            }
        }
        wait(for: [exp], timeout: 2.0)
        
        XCTAssertTrue(!capturedPhotos.isEmpty)
    }
    
    private func makeSUT() -> DefaultPhotoDataService {
        let provider = MoyaProvider<PhotoService>()
        return DefaultPhotoDataService(provider: provider)
    }
    
}
