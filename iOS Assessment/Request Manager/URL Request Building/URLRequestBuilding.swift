//
//  URLRequestBuilding.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation

protocol URLRequestBuilding {
    func urlRequest<E>(from endPoint: E) -> URLRequest? where E : EndPoint
}
