//
//  UIColor.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import UIKit

extension UIColor {
    static let lightGreen = UIColor(hexString: "12E47C")
    static var darkGreen = UIColor(hexString: "12C96E")
    static var lightGray = UIColor(hexString: "E8E8E8")
}

extension UIColor {
    
    convenience init(hexString: String?) {
        
        let hexStringColor = hexString ?? "#000000"
        
        let hex = hexStringColor.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
