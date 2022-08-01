//
//  UserViewModel.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation
import CoreLocation

class UserViewModel {
    
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var id: String? {
        user.id
    }
    
    var userObject: UserObject? {
        UserObject(user: user)
    }
    
    var name: String {
        let first = user.name?.first ?? ""
        let last = user.name?.last ?? ""
        return "\(first) \(last)".trimmingCharacters(in: .whitespaces)
    }
    
    var info: String {
        var gender = user.gender?.rawValue ?? "-"
        gender.capitalizeFirstLetter()
        let phone = user.phone ?? "-"
        return "\(gender), \(phone)".trimmingCharacters(in: .whitespaces)
    }
    
    var country: String {
        let country = user.location?.country ?? "-"
        return country.trimmingCharacters(in: .whitespaces)
    }
    
    var address: String {
        var fullAddress = ""
        
        if let state = user.location?.state {
            fullAddress += state
        }
        
        if let street = user.location?.street?.name {
            fullAddress += fullAddress.isEmpty ? street : ", \(street)"
            
            if let number = user.location?.street?.number {
                fullAddress += ", \(number)"
            }
        }
        
        return fullAddress.isEmpty ? "-" : fullAddress.trimmingCharacters(in: .whitespaces)
    }
    
    var mediumImage: String {
        user.picture?.medium ?? ""
    }
    
    var location: CLLocationCoordinate2D? {
        if let latitude = user.location?.coordinates?.latitude,
           let longitude = user.location?.coordinates?.longitude,
           let atitudeDegrees = CLLocationDegrees(latitude),
           let longitudeDegrees = CLLocationDegrees(longitude) {
            
            return CLLocationCoordinate2D(latitude: atitudeDegrees, longitude: longitudeDegrees)
        }
        
        return nil
    }
}
