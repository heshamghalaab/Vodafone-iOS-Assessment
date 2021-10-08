//
//  DataResponseDecoding.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation

enum DataResponseDecodeError: Error {
    case decodeToJsonFailed
}

protocol DataResponseDecoding {
    func decodeJson<E: EndPoint>(from endPoint: E, with data: Data) throws -> E.JSONResponseStructure
    func decodeModel<C: Decodable>(from data: Data) throws -> C
}
