//
//  UIImageView.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setAvatar(by urlString: String) {
        kf.setImage(with: URL(string: urlString), placeholder: nil, options: nil, progressBlock: nil) { [weak self] result in
            switch result {
            case .failure:
                self?.contentMode = .center
                self?.image = UIImage(systemName: "photo.artframe")
            case .success:
                self?.contentMode = .scaleAspectFill
            }
        }
    }
}
