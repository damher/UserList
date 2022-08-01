//
//  UsersBaseViewModel.swift
//  UserList
//
//  Created by Mher Davtyan on 29.07.22.
//

import Foundation

class UsersBaseViewModel: BaseViewModel, UsersBaseViewModelProtocol {
    
    private let networkManager: UserNetworkManagerProtocol
    private let realmManager: RealmManagerProtocol
    
    private var page = 0
    private var count = 20
    
    var isLastDataFetched: Bool = false
    
    @Observable(for: \UsersBaseViewModelProtocol.users)
    var users: [UserViewModel]?
    
    @Observable(for: \UsersBaseViewModelProtocol.savedUsers)
    var savedUsers: [UserViewModel]?
    
    @Observable(for: \UsersBaseViewModelProtocol.searchText)
    var searchText: String?
    
    var usersFiltered: [UserViewModel] {
        filterUsersBySearchRequest(users)
    }
    
    var savedUsersFiltered: [UserViewModel] {
        filterUsersBySearchRequest(savedUsers)
    }
    
    // MARK: Init
    
    init(networkManager: UserNetworkManagerProtocol, realmManager: RealmManagerProtocol) {
        self.networkManager = networkManager
        self.realmManager = realmManager
        
        super.init()
        
        $users.owner = self
        $savedUsers.owner = self
        $searchText.owner = self
    }
    
    func filterUsersBySearchRequest(_ users: [UserViewModel]?) -> [UserViewModel] {
        if let text = searchText?.lowercased(), !text.isEmpty {
            return users?.filter { $0.name.lowercased().hasPrefix(text) } ?? []
        }
        
        return users ?? []
    }
}

// MARK: - Requests
extension UsersBaseViewModel {
    
    func loadData() {
        networkManager.getUsesList(UsersResponseData.self, page: page, count: count) { [weak self] result in
            switch result {
            case .success(let data):
                let fetchedData = data.results?.map { UserViewModel(user: $0) } ?? []
                
                if self?.page == 0 {
                    self?.users = fetchedData
                } else {
                    self?.users?.append(contentsOf: fetchedData)
                }
                
                if let count = self?.count, count > fetchedData.count {
                    self?.isLastDataFetched = true
                }
                
                self?.page += 1
            case .failure(let error):
                self?.errorAction?(error)
            }
        }
    }
}

// MARK: - Realm
extension UsersBaseViewModel {
    
    func loadDefaultData() {
        savedUsers = realmManager.objects(UserObject.self).map { $0.toViewModel() }
    }
}
