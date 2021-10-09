//
//  PhotosCashingProviderTests.swift
//  iOS AssessmentTests
//
//  Created by Ghalaab on 09/10/2021.
//

import XCTest
@testable import iOS_Assessment

class PhotosCashingProviderTests: XCTestCase {

    func testProvider_whenEmpty() {
        // clean cash.
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let directory = cacheURL.appendingPathComponent("path")
        
        guard FileManager.default.isDeletableFile(atPath: directory.path) else { return }
        do {
            try FileManager.default.removeItem(atPath: directory.path)
        } catch { }
        
        let provider: PhotosCashingProviding = PhotosCashingProvider(path: "path")
        provider.loadIfExist { photos in
            XCTFail("Shouldn't have called")
        }
    }
    
    func testProvider_whenThereIsPhotos() {
        let provider: PhotosCashingProviding = PhotosCashingProvider(path: "newPath")
        let photos = [Photo(id: "0", author: "Hesham", url: "", downloadUrl: "")]
        provider.store(photos: photos)
        
        provider.loadIfExist { storedPhotos in
            XCTAssertEqual(photos, storedPhotos)
        }
    }
}
