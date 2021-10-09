//
//  Photo+Equatable.swift
//  iOS AssessmentTests
//
//  Created by Ghalaab on 09/10/2021.
//

import Foundation
@testable import iOS_Assessment

extension Photo: Equatable{
    public static func == (lhs: Photo, rhs: Photo) -> Bool {
        (lhs.downloadUrl == rhs.downloadUrl && lhs.url == rhs.url && lhs.author == rhs.author && lhs.id == rhs.id)
    }
}
