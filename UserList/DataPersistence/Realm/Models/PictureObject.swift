//
//  PictureObject.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import RealmSwift

class PictureObject: Object, Codable {
    @objc dynamic var large: String?
    @objc dynamic var medium: String?
    @objc dynamic var thumbnail: String?
    
    convenience init(picture: Picture?) {
        self.init()
        self.large = picture?.large
        self.medium = picture?.medium
        self.thumbnail = picture?.thumbnail
    }
}
