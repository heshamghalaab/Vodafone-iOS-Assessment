//
//  PhotoCellViewModelTests.swift
//  iOS AssessmentTests
//
//  Created by Ghalaab on 09/10/2021.
//

import XCTest
@testable import iOS_Assessment

class PhotoCellViewModelTests: XCTestCase {

    func testCellViewModel_outputs(){
        let photo = Photo(id: "", author: "authorName", url: "", downloadUrl: "photoUrl")
        let viewModel: PhotoCellViewModelProtocol = PhotoCellViewModel(photo: photo)
        XCTAssertEqual(viewModel.photoUrl, photo.downloadUrl)
        XCTAssertEqual(viewModel.authorName, photo.author)
    }
}
