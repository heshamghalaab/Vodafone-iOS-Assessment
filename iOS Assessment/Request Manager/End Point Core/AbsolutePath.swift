//
//  AbsolutePath.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation

enum AbsolutePath {
    case picsum(Picsum)
    
    var value: String{
        switch self {
        case .picsum(let path): return path.value
        }
    }
}

enum Picsum{
    
    case photos
    
    var value: String{
        switch self {
        case .photos: return "list"
        }
    }
}
