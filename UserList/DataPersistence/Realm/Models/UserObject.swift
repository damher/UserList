//
//  UserObject.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import RealmSwift

class UserObject: Object, Codable {
    @objc dynamic var id: String?
    @objc dynamic var gender: String?
    @objc dynamic var phone: String?
    @objc dynamic var name: NameObject?
    @objc dynamic var location: LocationObject?
    @objc dynamic var picture: PictureObject?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(user: User?) {
        self.init()
        self.id = user?.id
        self.gender = user?.gender?.rawValue
        self.phone = user?.phone
        self.name = NameObject(name: user?.name)
        self.location = LocationObject(location: user?.location)
        self.picture = PictureObject(picture: user?.picture)
    }
}

extension UserObject {
    
    func toViewModel() -> UserViewModel {
        let name = Name(title: name?.title, first: name?.first, last: name?.last)
        let gender = Gender(rawValue: gender ?? "")
        let picture = Picture(large: picture?.large, medium: picture?.medium, thumbnail: picture?.thumbnail)
        let coordinates = Coordinates(latitude: location?.coordinates?.latitude, longitude: location?.coordinates?.longitude)
        let street = Street(number: location?.street?.number.value, name: location?.street?.name)
        let location = Location(coordinates: coordinates,
                                country: location?.country,
                                state: location?.state,
                                city: location?.city,
                                street: street)
        let user = User(id: id, name: name, gender: gender, phone: phone, location: location, picture: picture)
        
        return UserViewModel(user: user)
    }
}
