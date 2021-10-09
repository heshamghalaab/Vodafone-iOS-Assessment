//
//  PhotoDetailsViewModelTests.swift
//  iOS AssessmentTests
//
//  Created by Ghalaab on 09/10/2021.
//

import XCTest
@testable import iOS_Assessment

class PhotoDetailsViewModelTests: XCTestCase {

    func testCellViewModel_outputs(){
        let photo = Photo(id: "", author: "authorName", url: "profileUrl", downloadUrl: "photoUrl")
        let viewModel: PhotoDetailsViewModelProtocol = PhotoDetailsViewModel(photo: photo)
        XCTAssertEqual(viewModel.photoUrl, photo.downloadUrl)
        XCTAssertEqual(viewModel.authorName, photo.author)
        XCTAssertEqual(viewModel.profileUrl, photo.url)
    }
}

