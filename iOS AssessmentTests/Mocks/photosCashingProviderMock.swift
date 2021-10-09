//
//  photosCashingProviderMock.swift
//  iOS AssessmentTests
//
//  Created by Ghalaab on 09/10/2021.
//

import Foundation
@testable import iOS_Assessment

class PhotosCashingProviderMock: PhotosCashingProviding{
    
    let localPhotos: [Photo]
    init(localPhotos: [Photo]){
        self.localPhotos = localPhotos
    }
    
    func loadIfExist(completion: @escaping ([Photo]) -> Void) {
            completion(localPhotos)
    }
    
    func store(photos: [Photo]) { }
}
