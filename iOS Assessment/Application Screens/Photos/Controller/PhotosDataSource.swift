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
        return viewModel.outputs.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let row = viewModel.inputs.photoRow(for: indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
            let cellViewModel = viewModel.inputs.photoCellViewModel(atRow: row)
            cell.configure(with: cellViewModel)
            return cell
        } else if let row = viewModel.inputs.adRow(for: indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as! AdTableViewCell
            cell.adTitleLabel.text = viewModel.inputs.adTitle(atRow: row)
            return cell
        }
        
        fatalError("Did not find data or ad for cell: Should never get here")
    }
}
