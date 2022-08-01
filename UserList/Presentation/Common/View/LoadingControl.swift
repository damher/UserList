//
//  LoadingControl.swift
//  UserList
//
//  Created by Mher Davtyan on 01.08.22.
//

import UIKit

public protocol LoadingControl: AnyObject {
    
    var overlay: UIView? { get set }
    var activityIndicator: UIActivityIndicatorView? { get set }
    
    func displayActivityIndicator(_ shouldDisplay: Bool, to view: UIView?, indicatorColor: UIColor?, backgroundColor: UIColor?)
    func setActivityIndicator(to view: UIView?, indicatorColor: UIColor?, backgroundColor: UIColor?)
    func removeActivityIndicator()
    func isDisplayingActivityIndicatorOverlay() -> Bool
}

public extension LoadingControl {
    
    func displayActivityIndicator(_ shouldDisplay: Bool, to view: UIView?, indicatorColor: UIColor?, backgroundColor: UIColor?) {
        if shouldDisplay {
            setActivityIndicator(to: view, indicatorColor: indicatorColor, backgroundColor: backgroundColor)
        } else {
            removeActivityIndicator()
        }
    }

    func setActivityIndicator(to view: UIView?, indicatorColor: UIColor?, backgroundColor: UIColor?) {
        guard !isDisplayingActivityIndicatorOverlay() else { return }
        guard let parentViewForOverlay = view else { return }

        overlay = UIView()
        activityIndicator = UIActivityIndicatorView()
        
        guard let overlay = overlay else { return }
        guard let activityIndicator = activityIndicator else { return }
        
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.backgroundColor = backgroundColor ?? .white

        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .whiteLarge
        }
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = indicatorColor

        //add subviews
        overlay.addSubview(activityIndicator)
        parentViewForOverlay.addSubview(overlay)

        //add overlay constraints
        overlay.heightAnchor.constraint(equalTo: parentViewForOverlay.heightAnchor).isActive = true
        overlay.widthAnchor.constraint(equalTo: parentViewForOverlay.widthAnchor).isActive = true

        //add indicator constraints
        activityIndicator.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: overlay.centerYAnchor).isActive = true

        //animate indicator
        activityIndicator.startAnimating()
    }

    func removeActivityIndicator() {
        UIView.animate(withDuration: 0.2, animations:{
            self.overlay?.alpha = 0.0
            self.activityIndicator?.stopAnimating()
        }) { _ in
            self.activityIndicator?.removeFromSuperview()
            self.overlay?.removeFromSuperview()
            self.activityIndicator = nil
            self.overlay = nil
        }
    }

    func isDisplayingActivityIndicatorOverlay() -> Bool {
        activityIndicator != nil && overlay != nil
    }
}
