//
//  ViewControllerTests.swift
//  RxMoyaExampleTests
//
//  Created by Arifin Firdaus on 12/03/21.
//

import XCTest
@testable import RxMoyaExample

class ViewControllerTests: XCTestCase {

    func test_viewDidLoad_outletsShouldNotNil() {
        let sut = makeSUT()
        
        sut.loadView()
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.titleLabel)
    }
    
    func test_viewDidLoad_outletsShouldInInitialState() {
        let sut = makeSUT()
        
        sut.loadView()
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.titleLabel.text, "")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        return storyboard.instantiateViewController(identifier: "ViewController") as! ViewController
    }

}
