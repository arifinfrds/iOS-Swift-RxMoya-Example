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
        let provider = MoyaProvider<PhotoService>(
            endpointClosure: defaultEndpointClosure,
            stubClosure: MoyaProvider.immediatelyStub
        )
        let sut = makeSUT(provider: provider)
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
    
    func test_fetchPhotos_deliversUnauthorizedError() {
        let provider = MoyaProvider<PhotoService>(
            endpointClosure: unauthorizedEndpointClosure,
            stubClosure: MoyaProvider.immediatelyStub
        )
        let sut = makeSUT(provider: provider)
        
        var capturedErrors: [DefaultPhotoDataService.Error] = []
        
        let result = sut.fetchPhotos()
            .toBlocking()
            .materialize()
        
        switch result {
        case .completed(let photos):
            XCTFail("Expect failed, got completed instead with photos: \(photos)")
        case .failed(_, let receivedError):
            if let error = receivedError as? DefaultPhotoDataService.Error {
                capturedErrors.append(error)
            }
        }
        
        XCTAssertEqual(capturedErrors, [.unauthorized])
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(provider: MoyaProvider<PhotoService>) -> DefaultPhotoDataService {
        return DefaultPhotoDataService(provider: provider)
    }
    
    private let defaultEndpointClosure = { (target: PhotoService) -> Endpoint in
        let url = URL(target: target).absoluteString
        return Endpoint(
            url: url,
            sampleResponseClosure: {.networkResponse(200, target.sampleData)},
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
    
    private let unauthorizedEndpointClosure = { (target: PhotoService) -> Endpoint in
        let url = URL(target: target).absoluteString
        return Endpoint(
            url: url,
            sampleResponseClosure: { EndpointSampleResponse.networkResponse(401, target.unauhtorizedSampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
}
