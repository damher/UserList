//
//  LocationObject.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import RealmSwift

class LocationObject: Object, Codable {
    @objc dynamic var coordinates: CoordinatesObject?
    @objc dynamic var street: StreetObject?
    @objc dynamic var country: String?
    @objc dynamic var state: String?
    @objc dynamic var city: String?
    
    convenience init(location: Location?) {
        self.init()
        self.coordinates = CoordinatesObject(coordinates: location?.coordinates)
        self.street = StreetObject(street: location?.street)
        self.country = location?.country
        self.state = location?.state
        self.city = location?.city
    }
}
