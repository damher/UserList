//
//  UITableView.swift
//  UserList
//
//  Created by Mher Davtyan on 29.07.22.
//

import UIKit

extension UITableView {
    
    func register(_ name: String) {
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
}
