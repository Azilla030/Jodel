//
//  FlickrApiSwiftTests.swift
//  JodelChallengeTests
//
//  Created by Alexander Ruder on 11.03.23.
//  Copyright © 2023 Jodel. All rights reserved.
//

import XCTest
@testable import JodelChallenge

class FlickrApiSwiftTests: XCTestCase {

    let api = FlickrApiSwift.shared
    
    func testFetchPhotos() {
        let expectation = XCTestExpectation(description: "Fetch photos from Flickr API")
        
        api.fetchPhotos(page: 1, perPage: 20) { (photos, error) in
            XCTAssertNotNil(photos)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testFetchPhotosPerformance() {
        self.measure {
            let expectation = self.expectation(description: "fetchPhotos")
            let api = FlickrApiSwift.shared
            api.fetchPhotos(page: 1, perPage: 10) { photos, error in
                XCTAssertNotNil(photos)
                XCTAssertNil(error)
                expectation.fulfill()
            }
            self.waitForExpectations(timeout: 10.0, handler: nil)
        }
    }
}
