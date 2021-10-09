//
//  PhotosViewModelTests.swift
//  iOS AssessmentTests
//
//  Created by Ghalaab on 09/10/2021.
//

import XCTest
@testable import iOS_Assessment

class PhotosViewModelTests: XCTestCase {

    func testFetching_whenSuccess(){
        let photos = Array(repeating: Photo(id: "0", author: "", url: "", downloadUrl: ""), count: 5)
        let viewModel: PhotosViewModelProtocol = PhotosViewModel(
            provider: PicsumProviderMock(result: .success(photos)),
            photosCashingProvider: PhotosCashingProviderMock(localPhotos: photos))
        
        viewModel.inputs.fetchPhotos()
        XCTAssertEqual(viewModel.outputs.numberOfItems, 6)
    }
    
    func testFetching_whenFailed(){
        let photos = Array(repeating: Photo(id: "0", author: "", url: "", downloadUrl: ""), count: 5)
        let viewModel: PhotosViewModelProtocol = PhotosViewModel(
            provider: PicsumProviderMock(result: .failure(.noContentReturned)),
            photosCashingProvider: PhotosCashingProviderMock(localPhotos: photos))
        
        viewModel.inputs.fetchPhotos()
        XCTAssertEqual(viewModel.outputs.numberOfItems, 6)
    }
    
    func testFetching_whenSuccessWithNoAds(){
        let photos = Array(repeating: Photo(id: "0", author: "", url: "", downloadUrl: ""), count: 4)
        let viewModel: PhotosViewModelProtocol = PhotosViewModel(
            provider: PicsumProviderMock(result: .failure(.noContentReturned)),
            photosCashingProvider: PhotosCashingProviderMock(localPhotos: photos))
        
        viewModel.inputs.fetchPhotos()
        XCTAssertEqual(viewModel.outputs.numberOfItems, 4)
    }
    
    func testPagination_withOneAd(){
        let photos = Array(repeating: Photo(id: "0", author: "", url: "", downloadUrl: ""), count: 4)
        let viewModel: PhotosViewModelProtocol = PhotosViewModel(
            provider: PicsumProviderMock(result: .success(photos)),
            photosCashingProvider: PhotosCashingProviderMock(localPhotos: photos))
        
        viewModel.inputs.fetchPhotos()
        viewModel.inputs.fetchMorePhotosIfAvailable(at: 3)
        XCTAssertEqual(viewModel.outputs.numberOfItems, 9)
    }
    
    func testPagination_withNoAds(){
        let photos = Array(repeating: Photo(id: "0", author: "", url: "", downloadUrl: ""), count: 2)
        let viewModel: PhotosViewModelProtocol = PhotosViewModel(
            provider: PicsumProviderMock(result: .success(photos)),
            photosCashingProvider: PhotosCashingProviderMock(localPhotos: photos))
        
        viewModel.inputs.fetchPhotos()
        viewModel.inputs.fetchMorePhotosIfAvailable(at: 1)
        XCTAssertEqual(viewModel.outputs.numberOfItems, 4)
    }
    
    func testPagination_whenNoOInternetConnection(){
        let photos = Array(repeating: Photo(id: "0", author: "", url: "", downloadUrl: ""), count: 2)
        let viewModel: PhotosViewModelProtocol = PhotosViewModel(
            provider: PicsumProviderMock(result: .failure(.noContentReturned)),
            photosCashingProvider: PhotosCashingProviderMock(localPhotos: photos))
        
        // Failed so it will get from local.
        viewModel.inputs.fetchPhotos()
        XCTAssertEqual(viewModel.outputs.numberOfItems, 2)
        
        // it should not Paginating.
        viewModel.inputs.fetchMorePhotosIfAvailable(at: 1)
        XCTAssertEqual(viewModel.outputs.numberOfItems, 2)
    }
    
    func testData_whenApplyingPagination(){
        let photos = Array(repeating: Photo(id: "0", author: "", url: "", downloadUrl: ""), count: 10)
        let providerMock = PicsumProviderMock(result: .success(photos))
        let viewModel: PhotosViewModelProtocol = PhotosViewModel(provider: providerMock)
        
        viewModel.inputs.fetchPhotos()
        viewModel.inputs.fetchMorePhotosIfAvailable(at: 11)
        viewModel.inputs.fetchMorePhotosIfAvailable(at: 23)
        
        XCTAssertEqual(viewModel.outputs.numberOfItems, 36)
        
        providerMock.result = .failure(.noContentReturned)
        XCTAssertEqual(viewModel.outputs.numberOfItems, 36)
    }

    func testPhotosArray(){
        let photos = Array(repeating: Photo(id: "0", author: "", url: "", downloadUrl: ""), count: 10)
        let providerMock = PicsumProviderMock(result: .success(photos))
        let viewModel: PhotosViewModelProtocol = PhotosViewModel(provider: providerMock)
        
        viewModel.inputs.fetchPhotos()
        
        XCTAssertNil(viewModel.inputs.photoRow(for: IndexPath(row: 5, section: 0)))
        XCTAssertNil(viewModel.inputs.photoRow(for: IndexPath(row: 11, section: 0)))
        XCTAssertEqual(viewModel.inputs.photoRow(for: IndexPath(row: 4, section: 0)), 4)
        XCTAssertEqual(viewModel.inputs.photoRow(for: IndexPath(row: 6, section: 0)), 5)
    }

    func testAdsArray(){
        let photos = Array(repeating: Photo(id: "0", author: "", url: "", downloadUrl: ""), count: 10)
        let providerMock = PicsumProviderMock(result: .success(photos))
        let viewModel: PhotosViewModelProtocol = PhotosViewModel(provider: providerMock)
        
        viewModel.inputs.fetchPhotos()
        
        XCTAssertNil(viewModel.inputs.adRow(for: IndexPath(row: 4, section: 0)))
        XCTAssertNil(viewModel.inputs.adRow(for: IndexPath(row: 10, section: 0)))
        XCTAssertEqual(viewModel.inputs.adRow(for: IndexPath(row: 5, section: 0)), 0)
        XCTAssertEqual(viewModel.inputs.adRow(for: IndexPath(row: 11, section: 0)), 1)
    }

    func testSelection_whenSelectingAd(){
        let photos = Array(repeating: Photo(id: "0", author: "", url: "", downloadUrl: ""), count: 10)
        let providerMock = PicsumProviderMock(result: .success(photos))
        let viewModel: PhotosViewModelProtocol = PhotosViewModel(provider: providerMock)
                
        viewModel.outputs.showPhotoInFullScreen = { _ in
            XCTFail("Shouldn't have called")
        }
        viewModel.inputs.fetchPhotos()
        viewModel.inputs.didSelectRow(at: IndexPath(row: 5, section: 0))
    }
    
    func testSelection_whenSelectingPhoto(){
        let photos = Array(repeating: Photo(id: "0", author: "", url: "", downloadUrl: ""), count: 10)
        let providerMock = PicsumProviderMock(result: .success(photos))
        let viewModel: PhotosViewModelProtocol = PhotosViewModel(provider: providerMock)
        
        viewModel.outputs.showPhotoInFullScreen = { vm in
            XCTAssertTrue(vm.photoUrl.isEmpty, "Passed.")
        }
        viewModel.inputs.fetchPhotos()
        viewModel.inputs.didSelectRow(at: IndexPath(row: 3, section: 0))
    }
}
