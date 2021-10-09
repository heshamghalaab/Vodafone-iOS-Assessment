//
//  PhotoCashingProviding.swift
//  iOS Assessment
//
//  Created by Ghalaab on 09/10/2021.
//

import Foundation

protocol PhotosCashingProviding{
    func loadIfExist(completion: @escaping (_ photos: [Photo]) -> Void)
    func store(photos: [Photo])
}
