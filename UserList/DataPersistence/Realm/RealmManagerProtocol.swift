//
//  RealmManagerProtocol.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import RealmSwift

protocol RealmManagerProtocol {
    func object<T: Object>(_ key: Any?) -> T?
    func objects<T: Object>(_ type: T.Type) -> [T]
    
    @discardableResult func update<T: Object>(_ object: T?) -> Bool
    @discardableResult func delete<T: Object>(_ object: T) -> Bool
}
