//
//  CoordinatesObject.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import RealmSwift

class CoordinatesObject: Object, Codable {
    @objc dynamic var latitude: String?
    @objc dynamic var longitude: String?
    
    convenience init(coordinates: Coordinates?) {
        self.init()
        self.latitude = coordinates?.latitude
        self.longitude = coordinates?.longitude
    }
}
