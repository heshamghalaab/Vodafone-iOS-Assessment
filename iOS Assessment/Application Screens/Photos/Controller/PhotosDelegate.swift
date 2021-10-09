//
//  PhotosDelegate.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import UIKit

class PhotosDelegate: NSObject, UITableViewDelegate{
    
    let viewModel: PhotosViewModelProtocol
    
    init(viewModel: PhotosViewModelProtocol) {
        self.viewModel = viewModel
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.inputs.fetchMorePhotosIfAvailable(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputs.didSelectRow(at: indexPath)
    }
}
