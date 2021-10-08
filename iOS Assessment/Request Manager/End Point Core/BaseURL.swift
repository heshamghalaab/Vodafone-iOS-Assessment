//
//  BaseURL.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation

enum BaseURL {
    case picsum
    
    var value: String{
        switch self {
        case .picsum: return "https://picsum.photos/v2/"
        }
    }
}
