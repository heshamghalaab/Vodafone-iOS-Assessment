//
//  DataResponseDecoder.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation

struct DataResponseDecoder: DataResponseDecoding {

    private let readingOptions: JSONSerialization.ReadingOptions

    init(readingOptions: JSONSerialization.ReadingOptions = .allowFragments) {
        self.readingOptions = readingOptions
    }

    func decodeJson<E: EndPoint>(from endPoint: E, with data: Data) throws -> E.JSONResponseStructure {
        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)
        guard let jsonDict = json as? E.JSONResponseStructure else {
            throw DataResponseDecodeError.decodeToJsonFailed
        }
        return jsonDict
    }

    func decodeModel<C: Decodable>(from data: Data) throws -> C {
        let decoder = JSONDecoder.makeDecoder(with: nil)
        return try decoder.decode(C.self, from: data)
    }
}

extension JSONDecoder {
    static func makeDecoder(with customDateFormat: String?) -> JSONDecoder {
        guard let customDateFormat = customDateFormat else { return JSONDecoder() }
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = customDateFormat
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
}
