//
//  User.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

struct User: Codable {
    let id: String?
    let name: Name?
    let gender: Gender?
    let phone: String?
    let location: Location?
    let picture: Picture?
    
    enum IdentifierCodingKeys: String, CodingKey {
        case value
    }
        
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case gender
        case phone
        case location
        case picture
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(Name.self, forKey: .name)
        gender = try container.decode(Gender.self, forKey: .gender)
        phone = try container.decode(String.self, forKey: .phone)
        location = try container.decode(Location.self, forKey: .location)
        picture = try container.decode(Picture.self, forKey: .picture)
            
        let identifierContainer = try container.nestedContainer(keyedBy: IdentifierCodingKeys.self, forKey: .id)
        id = try? identifierContainer.decode(String.self, forKey: .value)
    }
    
    init(id: String?, name: Name?, gender: Gender?, phone: String?, location: Location?, picture: Picture?) {
        self.id = id
        self.name = name
        self.gender = gender
        self.phone = phone
        self.location = location
        self.picture = picture
    }
}

struct Name: Codable {
    let title: String?
    let first: String?
    let last: String?
}

struct Location: Codable {
    var coordinates: Coordinates?
    var country: String?
    var state: String?
    var city: String?
    var street: Street?
}

struct Coordinates: Codable {
    let latitude: String?
    let longitude: String?
}

struct Street: Codable {
    let number: Int?
    let name: String?
}

struct Picture: Codable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}

enum Gender: String, Codable {
    case male
    case female
}
