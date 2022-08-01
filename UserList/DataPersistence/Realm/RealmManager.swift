//
//  RealmManager.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import RealmSwift

class RealmManager: RealmManagerProtocol {
    
    private var realm: Realm? {
        let configuration = Realm.Configuration(schemaVersion: 1)
        return try? Realm(configuration: configuration)
    }
    
    // MARK: Get object via id
    func object<T: Object>(_ key: Any?) -> T? {
        guard let key: Any = key else { return nil }
        guard let realm: Realm = self.realm else { return nil }
        guard let object: T = realm.object(ofType: T.self, forPrimaryKey: key) else { return nil }
        return !object.isInvalidated ? object : nil
    }
    
    // MARK: Get objects
    func objects<T: Object>(_ type: T.Type) -> [T] {
        guard let realm: Realm = self.realm else { return [] }
        return realm.objects(type).map({ $0 })
    }
    
    // MARK: Modify object
    func update<T: Object>(_ object: T?) -> Bool {
        guard let object: T = object else { return false }
        guard let realm: Realm = self.realm else { return false }
        
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
            return true
        } catch let error {
            debugPrint("Writing failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }
    
    // MARK: Delete object
    func delete<T: Object>(_ object: T) -> Bool {
        guard let realm: Realm = self.realm else { return false }
        guard !object.isInvalidated else { return true }
        do {
            try realm.write {
                realm.delete(object)
            }
            return true
        } catch let error {
            print("Writing of array failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }
}
