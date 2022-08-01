//
//  UserNetworkManagerProtocol.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

protocol UserNetworkManagerProtocol {
    func getUsesList<T: Decodable>(_ type: T.Type, page: Int, count: Int, completion: @escaping (Result<T>) -> Void)
}
