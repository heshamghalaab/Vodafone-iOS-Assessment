//
//  EndPointError+Equatable.swift
//  iOS AssessmentTests
//
//  Created by Ghalaab on 09/10/2021.
//

import Foundation
@testable import iOS_Assessment

extension EndPointError: Equatable {
    public static func == (lhs: EndPointError, rhs: EndPointError) -> Bool {
        switch (lhs, rhs) {
        case (.decodingError, .decodingError):
            return true
        case (.httpError(statusCode: let lhsStatusCode), .httpError(statusCode: let rhsStatusCode)):
            return lhsStatusCode == rhsStatusCode
        case (.invalidURLRequest, .invalidURLRequest):
            return true
        case (.message(let lhsValue), .message(let rhsValue )):
            return lhsValue == rhsValue
        case (.noContentReturned, .noContentReturned):
            return true
        default:
            return false
        }
    }
}
