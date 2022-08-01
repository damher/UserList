//
//  Observable.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

@propertyWrapper
class Observable<T> {

    let keyPath: AnyKeyPath

    weak var owner: BaseViewModelProtocol?

    init(for keyPath: AnyKeyPath) {
        self.keyPath = keyPath
    }

    var wrappedValue: T? {
        didSet {
            owner?.propertyChanged?(keyPath)
        }
    }

    var projectedValue: Observable {
        self
    }
}
