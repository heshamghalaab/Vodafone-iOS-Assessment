//
//  DataResponseHandling.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation

protocol DataResponseHandling {
    func handleRequestResponse<E>(_ data: Data? , error: Error?, response: URLResponse?, from endPoint: E, completionHandler: @escaping (Result<Data, EndPointError>) -> Void) where E: EndPoint
}
