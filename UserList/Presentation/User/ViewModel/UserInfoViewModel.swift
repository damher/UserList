//
//  UserInfoViewModel.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

class UserInfoViewModel: BaseViewModel, UserInfoViewModelProtocol {
    
    private let realmManager: RealmManagerProtocol
    private let userViewModel: UserViewModel?
    
    var user: UserObject?
    
    var userDataUpdated: (() -> Void)?
    var userDataRequested: (() -> Void)?
    
    // MARK: Init
    
    init(realmManager: RealmManagerProtocol, userViewModel: UserViewModel?) {
        self.realmManager = realmManager
        self.userViewModel = userViewModel
        
        super.init()
    }
}

// MARK: - Realm
extension UserInfoViewModel {
    
    func fetchUser() {
        user = realmManager.object(userViewModel?.id)
        userDataRequested?()
    }
    
    func save() {
        let updated = realmManager.update(userViewModel?.userObject)
        
        if updated {
            user = realmManager.object(userViewModel?.id)
            userDataUpdated?()
        }
    }
    
    func remove() {
        if let user = user {
            let deleted = realmManager.delete(user)
            
            if deleted {
                self.user = nil
                userDataUpdated?()
            }
        }
    }
}
