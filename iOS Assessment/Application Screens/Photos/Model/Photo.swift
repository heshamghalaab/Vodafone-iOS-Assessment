//
//  Photo.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation

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
