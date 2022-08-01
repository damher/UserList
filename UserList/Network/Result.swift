//
//  Result.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error?)
}
