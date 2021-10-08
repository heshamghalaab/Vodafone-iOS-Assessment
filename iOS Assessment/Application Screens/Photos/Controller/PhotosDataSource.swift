//
//  PhotosDataSource.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import UIKit

class PhotosDataSource: NSObject, UITableViewDataSource{
    
    let viewModel: PhotosViewModelProtocol
    
    init(viewModel: PhotosViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputs.numberOfPhotos
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
        let cellViewModel = viewModel.inputs.photoCellViewModel(atRow: indexPath.row)
        cell.configure(with: cellViewModel)
        return cell
    }
}
