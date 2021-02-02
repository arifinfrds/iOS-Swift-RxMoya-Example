//
//  DefaultPhotoDataServiceTests.swift
//  RxMoyaExampleTests
//
//  Created by Arifin Firdaus on 02/02/21.
//

import XCTest
import Moya
import RxBlocking
@testable import RxMoyaExample

class DefaultPhotoDataServiceTests: XCTestCase {
    
    func test_fetchPhotos_deliverPhotos() {
        let sut = makeSUT()
        var capturedPhotos: [Photo] = []
        
        do {
            guard let photos = try sut.fetchPhotos().toBlocking().first() else {
                XCTFail("expect photos but nil instead")
                return
            }
            capturedPhotos = photos
        } catch {
            XCTFail("expect photos but failed instead with error: \(error)")
        }
        
        XCTAssertTrue(!capturedPhotos.isEmpty)
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT() -> DefaultPhotoDataService {
        let provider = MoyaProvider<PhotoService>(stubClosure: MoyaProvider.immediatelyStub)
        return DefaultPhotoDataService(provider: provider)
    }
    
    
}
