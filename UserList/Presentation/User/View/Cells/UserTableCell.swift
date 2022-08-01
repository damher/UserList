//
//  UserTableCell.swift
//  UserList
//
//  Created by Mher Davtyan on 29.07.22.
//

import UIKit

class UserTableCell: UITableViewCell {

    @IBOutlet private weak var avatarView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarView.image = nil
    }
    
    func setData(_ viewModel: UserViewModel) {
        avatarView.setAvatar(by: viewModel.mediumImage)
        nameLabel.text = viewModel.name
        infoLabel.text = viewModel.info
        countryLabel.text = viewModel.country
        addressLabel.text = viewModel.address
    }
}
