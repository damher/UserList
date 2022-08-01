//
//  BaseViewModelProtocol.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

protocol BaseViewModelProtocol: AnyObject {
    
    var propertyChanged: ((AnyKeyPath) -> Void)? { get set }
    var errorAction: ((Error?) -> Void)? { get set }
}
