//
//  DataResponseDecoderTests.swift
//  iOS AssessmentTests
//
//  Created by Ghalaab on 09/10/2021.
//

import XCTest
@testable import iOS_Assessment

class DataResponseDecoderTests: XCTestCase {
       
    func testDecodeJSSON_whenTheJsonIsValid() {
        let photo = Photo(id: "0", author: "hesham", url: "", downloadUrl: "")
        
        var expectedData: Data!
        
        do {
            expectedData = try JSONEncoder().encode(photo)
        } catch  {
            XCTFail("Failed To Encode")
        }
        
        let dataResponseDecoder: DataResponseDecoding = DataResponseDecoder()
        do {
            let model: Photo = try dataResponseDecoder.decodeModel(from: expectedData)
            XCTAssertEqual(model, photo)
        } catch  {
            XCTFail("Shouldn't have called")
        }
        
    }
    
    func testDecodeJSON_whenTheJsonIsInvalid() {
        var expectedData: Data!
        
        do {
            expectedData = try JSONSerialization.data(withJSONObject: [["id": 0]], options: .prettyPrinted)
        } catch  {
            XCTFail("Failed to archived Data")
        }
        
        let dataResponseDecoder: DataResponseDecoding = DataResponseDecoder()
        do {
            let _: Photo = try dataResponseDecoder.decodeModel(from: expectedData)
            XCTFail("Shouldn't have called")
        } catch  { }
    }
}
