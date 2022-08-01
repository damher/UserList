//
//  StreetObject.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import RealmSwift

class StreetObject: Object, Codable {
    var number = RealmProperty<Int?>()
    @objc dynamic var name: String?
    
    convenience init(street: Street?) {
        self.init()
        self.number.value = street?.number
        self.name = street?.name
    }
}
