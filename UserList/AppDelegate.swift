//
//  AppDelegate.swift
//  UserList
//
//  Created by Mher Davtyan on 28.07.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ServiceLocator.instance.registerDependencies()
        
        return true
    }
}

