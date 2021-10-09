//
//  URLSessionMock.swift
//  iOS AssessmentTests
//
//  Created by Ghalaab on 09/10/2021.
//

import Foundation
@testable import iOS_Assessment

struct URLSessionMock: URLSessionRequesting {
    let shouldError: Bool
    let error: EndPointError
    let expectedData: Data
    let sessionDataTask = URLSession.shared.dataTask(with: URL(string: BaseURL.picsum.value)!)
    let response: HTTPURLResponse?

    init(shouldError: Bool = false, withError error: EndPointError = .noContentReturned, expectedData: Data = Data(), response: HTTPURLResponse? = HTTPURLResponse()) {
        self.shouldError = shouldError
        self.error = error
        self.expectedData = expectedData
        self.response = response
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        guard !shouldError else {
            completionHandler(nil, response, error)
            return sessionDataTask
        }
        
        completionHandler(expectedData, nil, nil)
        return sessionDataTask
    }
}
