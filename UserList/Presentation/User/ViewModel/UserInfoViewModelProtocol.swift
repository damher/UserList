//
//  UserInfoViewModelProtocol.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

protocol UserInfoViewModelProtocol: BaseViewModelProtocol {
    var user: UserObject? { get set }
    var userDataRequested: (() -> Void)? { get set }
    var userDataUpdated: (() -> Void)? { get set }
    
    func fetchUser()
    func save()
    func remove()
}
