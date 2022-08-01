//
//  UserRouter.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation
import UIKit

class UserRouter {
    
    static var shared = UserRouter()
    
    private let storyboard = UIStoryboard(name: "User", bundle: nil)
    
    private init() {}
    
    func openUserInfoPage(_ navigationController: UINavigationController?, delegate: UIViewController, data: UserViewModel?) {
        if let vc: UserInfoViewController = storyboard.instantiate() {
            vc.userData = data
            vc.delegate = delegate as? UserInfoViewControllerDelegate
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
