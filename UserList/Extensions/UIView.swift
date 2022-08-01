//
//  UIView.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}

extension UIView {

    func applyGradient(colours: [UIColor], locations: [NSNumber]?) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.type = .radial
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        
        if let gradientSublayer = self.layer.sublayers?.first(where: { $0.isKind(of: CAGradientLayer.self) }) {
            self.layer.replaceSublayer(gradientSublayer, with: gradient)
            return
        }
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}
