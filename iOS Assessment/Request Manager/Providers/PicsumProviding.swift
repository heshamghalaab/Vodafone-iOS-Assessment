//
//  PicsumProviding.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation

protocol PicsumProviding {
    func photos(forPage page: Int, withLimit limit: Int, completion: @escaping (Result<[Photo], EndPointError>) -> Void)
}

struct PicsumProvider: PicsumProviding {
    
    private let requestManager: CanRequestFeeds
    
    init(requestManager: CanRequestFeeds = RequestManager()) {
        self.requestManager = requestManager
    }
    
    func photos(forPage page: Int, withLimit limit: Int, completion: @escaping (Result<[Photo], EndPointError>) -> Void){
        let parameters = PhotosParameters(page: page, limit: limit)
        let endPoint = RequestEndPoint<[Photo], PhotosParameters>(
            baseURL: .picsum, absolutePath: .picsum(.photos),
            parameters: parameters, httpMethod: .get, headers: [:])
        requestManager.request(from: endPoint, completionHandler: completion)
    }
}

struct PhotosParameters: Encodable {
    let page: Int
    let limit: Int
}

struct Photo: Codable {
    let id: String
    let author: String?
    let url: String?
    let downloadUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case url = "url"
        case downloadUrl = "download_url"
    }
}
