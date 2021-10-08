//
//  DataResponseHandler.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation
import os.log

struct DataResponseHandler: DataResponseHandling {
    
    func handleRequestResponse<E>(_ data: Data? , error: Error?, response: URLResponse?, from endPoint: E, completionHandler: @escaping (Result<Data, EndPointError>) -> Void) where E: EndPoint {
        
        if let error = error{
            os_log("Error In Requesting %@ %@", log: .requestsLogger, type: .error, "\(E.self)", error.localizedDescription)
            completionHandler(.failure(.message(error.localizedDescription)))
            return
        }
        
        guard let data = data else {
            os_log("Error getting data from %@", log: .requestsLogger, type: .error, "\(E.self)")
            completionHandler(.failure(.noContentReturned))
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            os_log("Status code: %@", log: .requestsLogger, type: .error, "\(httpResponse.statusCode)")
            completionHandler(.failure(.httpError(statusCode: httpResponse.statusCode)))
            return
        }
        
        completionHandler(.success(data))
    }

}
