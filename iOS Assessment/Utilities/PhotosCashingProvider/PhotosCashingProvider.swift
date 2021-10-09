//
//  PhotoCashingProvider.swift
//  iOS Assessment
//
//  Created by Ghalaab on 09/10/2021.
//

import Foundation

class PhotosCashingProvider: PhotosCashingProviding{
    
    private let PATH: String = "localPhotos"
    
    private func cacheFileUrl(_ fileName: String) -> URL {
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return cacheURL.appendingPathComponent(fileName)
    }
    
    func loadIfExist(completion: @escaping (_ photos: [Photo]) -> Void ){
        let fileURL = cacheFileUrl(PATH)
        do {
            let data = try Data(contentsOf: fileURL)
            let photos = try JSONDecoder().decode([Photo].self, from: data)
            completion(photos)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func store(photos: [Photo]){
        let fileURL = cacheFileUrl(PATH)
        do {
            let data = try JSONEncoder().encode(photos)
            try data.write(to: fileURL, options: Data.WritingOptions.atomic)
        } catch let error {
            print("Error \(error.localizedDescription)")
        }
    }
}
