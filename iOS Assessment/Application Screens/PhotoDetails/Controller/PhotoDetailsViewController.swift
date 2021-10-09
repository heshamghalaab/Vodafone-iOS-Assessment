//
//  PhotoDetailsViewController.swift
//  iOS Assessment
//
//  Created by Ghalaab on 09/10/2021.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorDetailsStackView: UIStackView!
    
    // MARK: Properties
    
    var viewModel: PhotoDetailsViewModelProtocol!
    
    // MARK: - View controller lifecycle methods

    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        addTapGesture()
    }
    
    // MARK: - Configuration methods
    
    // Adding Tap Gesture in order to Open author Profile.
    private func addTapGesture(){
        self.authorDetailsStackView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapOpenProfile))
        authorDetailsStackView.addGestureRecognizer(tapGesture)
    }
    
    @objc func onTapOpenProfile() {
        guard let url = URL(string: viewModel.profileUrl) else { return }
        UIApplication.shared.open(url)
    }
    
    func setupData(){
        self.authorNameLabel.text = viewModel.authorName
        self.photoImageView.sd_setImage(
            with: URL(string: viewModel.photoUrl), placeholderImage: UIImage(named: "place_holder"))
    }
}
