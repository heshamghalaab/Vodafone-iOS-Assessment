//
//  DataRequesting.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation

protocol DataRequesting{
    func requestData<E>(from endPoint: E, completionHandler: @escaping (Result<Data, EndPointError>) -> Void) where E: EndPoint
}
