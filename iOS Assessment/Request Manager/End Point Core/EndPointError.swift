//
//  EndPointError.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation

enum EndPointError: Error {
    case noContentReturned
    case invalidURLRequest
    case decodingError
    case httpError(statusCode: Int)
    case message(String)
    
    var errorDescription: String? {
        switch self {
        case .noContentReturned: return "No Content Found, please try again later."
        case .invalidURLRequest: return "Invalid url, please contact support."
        case .decodingError: return "Decoding error, please contact support."
        case .httpError(let code): return "Error with code: \(code), please contact support."
        case .message(let value): return value
        }
    }
}
