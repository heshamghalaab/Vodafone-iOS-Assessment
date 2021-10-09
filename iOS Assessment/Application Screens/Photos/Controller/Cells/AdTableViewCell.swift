//
//  AdTableViewCell.swift
//  iOS Assessment
//
//  Created by Ghalaab on 09/10/2021.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var adTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShadow(to: shadowView)
        shadowView.backgroundColor = UIColor(
            red: .random(in: 0.1...1),
            green: .random(in: 0.1...1),
            blue: .random(in: 0.1...1),
            alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    private func addShadow(to view: UIView){
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 3.6
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
    }
}
