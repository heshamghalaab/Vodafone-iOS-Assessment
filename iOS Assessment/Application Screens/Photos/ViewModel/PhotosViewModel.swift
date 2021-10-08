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
    
    
    init(provider: PicsumProviding = PicsumProvider()) {
        self.provider = provider
    }
    
    /// Inputs
    
    func fetchPhotos(){
        provider.photos(forPage: 1, withLimit: 20) { result in
            switch result{
            case .failure(let error):
                self.failureAlert?(error.errorDescription ?? "Unexpected error.")
            case .success(let photos):
                self.photos = photos
                self.reloadData?()
            }
        }
    }
    
    func photoCellViewModel(atRow row: Int) -> PhotoCellViewModelProtocol{
        PhotoCellViewModel(photo: photos[row])
    }
    
    /// OutPuts
    
    var showLoading: ( (_ show: Bool) -> Void )?
    var reloadData: ( () -> Void )?
    var numberOfPhotos: Int { photos.count }
    var failureAlert: ((String) -> Void)?
}
