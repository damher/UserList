//
//  UserNetworkManager.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

class UserNetworkManager: BaseNetworkManager, UserNetworkManagerProtocol {
    
    func getUsesList<T>(_ type: T.Type, page: Int, count: Int, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        
        let parametres = [
            Const.Key.seed.rawValue: Const.renderforest.rawValue,
            Const.Key.results.rawValue: String(describing: count),
            Const.Key.page.rawValue: String(describing: page)
        ]
                
        session.execute(url: Endpoint.path(for: .api), parameters: parametres, headers: headers) { result in
            completion(result)
        }
    }
}
