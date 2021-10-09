//
//  DataRequesterTests.swift
//  iOS AssessmentTests
//
//  Created by Ghalaab on 09/10/2021.
//

import XCTest
@testable import iOS_Assessment

class DataRequesterTests: XCTestCase {
   
    let absolutePath = BaseURL.picsum.value
    
    func testRequestingData_whenTheRequestIsSucceed() {
        var expectedData: Data!
        
        do {
            expectedData = try JSONEncoder().encode(Photo(id: "0", author: "Alejandro Escamilla", url: "URL", downloadUrl: "IMAGE"))
        } catch  {
            XCTFail("Failed to archived Data")
        }
        
        let urlSessionMock: URLSessionRequesting = URLSessionMock(expectedData: expectedData)
        let dataRequester: DataRequesting = DataRequester(urlSession: urlSessionMock)
        
        let parameters = PhotosParameters(page: 1, limit: 10)
        let endPoint = RequestEndPoint<[Photo], PhotosParameters>(
            baseURL: .picsum, absolutePath: .picsum(.photos),
            parameters: parameters, httpMethod: .get, headers: [:])
        
        var fetchedData: Data!
        dataRequester.requestData(from: endPoint) {
            switch $0 {
            case .success(let data):
                fetchedData = data
            case .failure(_):
                XCTFail("Shouldn't have called")
            }
        }
        
        XCTAssertEqual(fetchedData, expectedData)
    }
    
    func testRequestingData_whenTheRequestIsFailed() {

        let urlSessionMock: URLSessionRequesting = URLSessionMock(shouldError: true, withError: .noContentReturned)
        let dataRequester: DataRequesting = DataRequester(urlSession: urlSessionMock, dataResponseHandler: DataResponseHandlerMock())
        
        let parameters = PhotosParameters(page: 1, limit: 10)
        let endPoint = RequestEndPoint<[Photo], PhotosParameters>(
            baseURL: .picsum, absolutePath: .picsum(.photos),
            parameters: parameters, httpMethod: .get, headers: [:])

        var responseError: EndPointError!
        dataRequester.requestData(from: endPoint) {
            switch $0 {
            case .success(_):
                XCTFail("Shouldn't have called")
            case .failure(let error):
                responseError = error
            }
        }

        XCTAssertEqual(responseError, .noContentReturned)
    }
}

fileprivate struct DataResponseHandlerMock: DataResponseHandling {
    func handleRequestResponse<E>(_ data: Data? , error: Error?, response: URLResponse?, from endPoint: E, completionHandler: @escaping (Result<Data, EndPointError>) -> Void) where E: EndPoint {
        completionHandler(.failure(.noContentReturned))
    }
}

