//
//  Const.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

enum Const: String {
    case renderforest
    case applicationJson = "application/json"
    
    enum Key: String {
        case seed
        case results
        case page
        case contentType = "Content-Type"
    }
}
