//
//  Endpoint.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

enum Endpoint: String {
    case baseUrl = "https://randomuser.me"
    case imageUrl = "https://openweathermap.org"
    
    static func path(for tail: Tail) -> String {
        baseUrl.rawValue + tail.rawValue
    }
    
    static func path(for image: String) -> String {
        baseUrl.rawValue + String(format: Tail.image.rawValue, image)
    }
}

// MARK: - Tail
enum Tail: String {
    case api = "/api"
    case image = "/img/w/%1$@.png"
}
