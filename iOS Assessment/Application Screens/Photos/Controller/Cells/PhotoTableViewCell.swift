//
//  PhotoTableViewCell.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
        
    // MARK: - Overrided methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Configuration methods
    
    func configure(with viewModel: PhotoCellViewModelProtocol){
        self.authorNameLabel.text = viewModel.outputs.authorName
        self.photoImageView.sd_setImage(
            with: URL(string: viewModel.outputs.photoUrl),
            placeholderImage: UIImage(named: "place_holder"))
    }
}
