//
//  PhotoCellViewModel.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation

protocol PhotoCellViewModelInputs {
}

protocol PhotoCellViewModelOutputs {
    var authorName: String { get }
    var photoUrl: String { get }
}

protocol PhotoCellViewModelProtocol: AnyObject {
    var inputs: PhotoCellViewModelInputs { get }
    var outputs: PhotoCellViewModelOutputs { get set }
}

class PhotoCellViewModel: PhotoCellViewModelInputs, PhotoCellViewModelOutputs, PhotoCellViewModelProtocol {
    
    var inputs: PhotoCellViewModelInputs { self }
    var outputs: PhotoCellViewModelOutputs {
        get { self }
        set { }
    }
    
    private let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    var authorName: String { photo.author ?? "" }
    var photoUrl: String { photo.downloadUrl ?? "" }
    
}
