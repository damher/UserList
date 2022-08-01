//
//  UsersBaseViewModelProtocol.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

protocol UsersBaseViewModelProtocol: BaseViewModelProtocol {
    
    var users: [UserViewModel]? { get set }
    var savedUsers: [UserViewModel]? { get set }
    var searchText: String? { get set }
    var isLastDataFetched: Bool { get set }
    var usersFiltered: [UserViewModel] { get }
    var savedUsersFiltered: [UserViewModel] { get }
    
    func loadData()
    func loadDefaultData()
}
