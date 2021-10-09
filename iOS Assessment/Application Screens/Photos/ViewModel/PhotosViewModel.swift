//
//  PhotosViewModel.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation

protocol PhotosViewModelInputs {
    func fetchPhotos()
    func photoCellViewModel(atRow row: Int) -> PhotoCellViewModelProtocol
    func fetchMorePhotosIfAvailable(at row: Int)
}

protocol PhotosViewModelOutputs {
    var showLoading: ( (_ show: Bool) -> Void )? { get set }
    var reloadData: ( () -> Void )? { get set }
    var numberOfPhotos: Int { get }
    var failureAlert: ( (_ message: String) -> Void )? { get set }
}

protocol PhotosViewModelProtocol: AnyObject {
    var inputs: PhotosViewModelInputs { get }
    var outputs: PhotosViewModelOutputs { get set }
}

class PhotosViewModel: PhotosViewModelInputs, PhotosViewModelOutputs, PhotosViewModelProtocol {
    
    var inputs: PhotosViewModelInputs { self }
    var outputs: PhotosViewModelOutputs {
        get { self }
        set { }
    }
    
    private let provider: PicsumProviding
    private var photos: [Photo] = []
    private var page: Int = 1
    private var isGettingPhotos: Bool = false
    private var didFetchLastPage: Bool = false
    
    init(provider: PicsumProviding = PicsumProvider()) {
        self.provider = provider
    }
    
    /// Inputs
    
    func fetchPhotos(){
        isGettingPhotos = true
        showLoading?(true)
        provider.photos(forPage: page, withLimit: 10) { [weak self] result in
            guard let self = self else { return }
            self.isGettingPhotos = false
            self.showLoading?(false)
            
            switch result{
            case .failure(let error):
                self.failureAlert?(error.errorDescription ?? "Unexpected error.")
            case .success(let photos):
                // If photos returned as an empty array so we are at the last page.
                self.didFetchLastPage = photos.isEmpty
                if self.page == 1 { self.photos = photos }
                else { self.photos.append(contentsOf: photos) }
                
                self.reloadData?()
            }
        }
    }
    
    func photoCellViewModel(atRow row: Int) -> PhotoCellViewModelProtocol{
        PhotoCellViewModel(photo: photos[row])
    }
    
    func fetchMorePhotosIfAvailable(at row: Int){
        guard !isGettingPhotos else { return }
        guard (row + 1) == photos.count else { return }
        guard !didFetchLastPage else { return }
        page += 1
        self.fetchPhotos()
    }
    
    /// OutPuts
    
    var showLoading: ( (_ show: Bool) -> Void )?
    var reloadData: ( () -> Void )?
    var numberOfPhotos: Int { photos.count }
    var failureAlert: ((String) -> Void)?
}
