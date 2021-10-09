//
//  PhotoDetailsViewModel.swift
//  iOS Assessment
//
//  Created by Ghalaab on 09/10/2021.
//

import Foundation

protocol PhotoDetailsViewModelProtocol: PhotoCellViewModelProtocol {
    var profileUrl: String { get }
}

class PhotoDetailsViewModel: PhotoDetailsViewModelProtocol {
    
    private let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    var authorName: String { photo.author ?? "" }
    var photoUrl: String { photo.downloadUrl ?? "" }
    var profileUrl: String { photo.url ?? "" }
}
