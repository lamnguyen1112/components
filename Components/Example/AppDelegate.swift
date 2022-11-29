//
//  AppDelegate.swift
//  Example
//
//  Created by Lazyman on 11/29/22.
//

import UIKit
import LNExtensions

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController.instanceFromNibClass()
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
}
