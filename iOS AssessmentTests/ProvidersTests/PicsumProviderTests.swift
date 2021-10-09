//
//  PicsumProviderTests.swift
//  iOS AssessmentTests
//
//  Created by Ghalaab on 09/10/2021.
//

import XCTest
@testable import iOS_Assessment

class PicsumProviderTests: XCTestCase {

    func testProvider_whenSucceed() {
        var expectedData: Data!
        let photos = [Photo(id: "0", author: "Alejandro Escamilla", url: "URL", downloadUrl: "IMAGE")]

        do {
            expectedData = try JSONEncoder().encode(photos)
        } catch  {
            XCTFail("Failed to archived Data")
        }
        
        let mockedRequestManager = MockedRequestManager(shouldError: false, expectedData: expectedData)
        let provider: PicsumProviding = PicsumProvider(requestManager: mockedRequestManager)
        
        var fetchedPhotos: [Photo] = []
        provider.photos(forPage: 1, withLimit: 10) {
            switch $0 {
            case .success(let photos):
                fetchedPhotos = photos
            case .failure(_):
                XCTFail("Shouldn't have called")
            }
        }
        
        XCTAssertEqual(fetchedPhotos, photos)
    }
    
    func testProvider_whenFailed() {
        var expectedData: Data!
        do {
            expectedData = try JSONEncoder().encode(["id": 28])
        } catch  {
            XCTFail("Failed to archived Data")
        }
        
        let mockedRequestManager = MockedRequestManager(shouldError: true, error: .decodingError, expectedData: expectedData)
        let provider: PicsumProviding = PicsumProvider(requestManager: mockedRequestManager)
        
        var fetchedError: EndPointError!
        provider.photos(forPage: 1, withLimit: 10) {
            switch $0 {
            case .success(_):
                XCTFail("Shouldn't have called")
            case .failure(let error):
                fetchedError = error
            }
        }
        
        XCTAssertEqual(fetchedError, .decodingError)
    }
}
