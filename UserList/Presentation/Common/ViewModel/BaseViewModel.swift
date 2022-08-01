//
//  BaseViewModel.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

class BaseViewModel: BaseViewModelProtocol {
    
    var propertyChanged: ((AnyKeyPath) -> Void)?
    var errorAction: ((Error?) -> Void)?
}
