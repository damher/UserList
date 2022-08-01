//
//  BaseNetworkManager.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

class BaseNetworkManager {
    
    let session: URLSession
    
    var headers: [String: String] {
        [Const.Key.contentType.rawValue: Const.applicationJson.rawValue]
    }
        
    // MARK: Init
    init() {
        self.session = URLSession.shared
    }
}
