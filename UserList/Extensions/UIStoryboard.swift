//
//  UIStoryboard.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import UIKit

extension UIStoryboard {
    
    func instantiate<T: UIViewController>() -> T? {
        instantiateViewController(withIdentifier: T.name) as? T
    }
}
