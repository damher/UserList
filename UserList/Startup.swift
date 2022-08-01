//
//  Startup.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation


import Swinject
import SwinjectAutoregistration

extension Container {
    
    func registerDependencies() {
        
        // MARK: Local Storage Registration
        self.autoregister(RealmManagerProtocol.self, initializer: RealmManager.init)
        
        // MARK: Networking Registration
        self.autoregister(UserNetworkManagerProtocol.self, initializer: UserNetworkManager.init)
        
        // MARK: ViewModels Registration
        self.autoregister(UsersBaseViewModelProtocol.self, initializer: UsersBaseViewModel.init)
        self.autoregister(UserInfoViewModelProtocol.self, argument: UserViewModel?.self, initializer: UserInfoViewModel.init)
    }
}
