//
//  PicsumProviderMock.swift
//  iOS AssessmentTests
//
//  Created by Ghalaab on 09/10/2021.
//

import Foundation
@testable import iOS_Assessment

class PicsumProviderMock: PicsumProviding{
    var result: Result<[Photo], EndPointError>
    
    init(result: Result<[Photo], EndPointError>){
        self.result = result
    }
    
    func photos(forPage page: Int, withLimit limit: Int, completion: @escaping (Result<[Photo], EndPointError>) -> Void) {
        completion(result)
    }
}
