//
//  PhotosDataSourceTests.swift
//  iOS AssessmentTests
//
//  Created by Ghalaab on 09/10/2021.
//

import XCTest
@testable import iOS_Assessment

class PhotosDataSourceTests: XCTestCase {
    
    func testValueInDataSource_withOutAds() {
        let photos = [Photo(id: "0", author: "", url: "", downloadUrl: "")]
        
        let viewModel: PhotosViewModelProtocol = PhotosViewModel(
            provider: PicsumProviderMock(result: .success(photos)),
            photosCashingProvider: PhotosCashingProviderMock(localPhotos: photos))
        
        viewModel.inputs.fetchPhotos()
        let dataSource = PhotosDataSource(viewModel: viewModel)
        
        let tableView = UITableView(frame: UIScreen.main.bounds)
        
        tableView.dataSource = dataSource
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfSections, 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testValueInDataSource_withAds() {
        
        let photos = Array(repeating: Photo(id: "0", author: "", url: "", downloadUrl: ""), count: 6)
        let viewModel: PhotosViewModelProtocol = PhotosViewModel(
            provider: PicsumProviderMock(result: .success(photos)),
            photosCashingProvider: PhotosCashingProviderMock(localPhotos: photos))
        
        viewModel.inputs.fetchPhotos()
        let dataSource = PhotosDataSource(viewModel: viewModel)
        
        let tableView = UITableView(frame: UIScreen.main.bounds)
        
        tableView.dataSource = dataSource
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfSections, 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 7)
    }
}
