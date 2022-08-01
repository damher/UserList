//
//  NameObject.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import RealmSwift
import Foundation

class NameObject: Object, Codable {
    @objc dynamic var title: String?
    @objc dynamic var first: String?
    @objc dynamic var last: String?
    
    convenience init(name: Name?) {
        self.init()
        self.title = name?.title
        self.first = name?.first
        self.last = name?.last
    }
}
