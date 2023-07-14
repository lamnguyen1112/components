//
//  AppDelegate.swift
//  Components-Example
//
//  Created by Lazyman on 7/14/23.
//

import UIKit
import Extensions

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    setupRootViewController()
    return true
  }
  
}

extension AppDelegate {
  func setupRootViewController() {
    window = UIWindow(frame: UIScreen.main.bounds)
    let viewController = ViewController.instanceFromNibClass()
    let navigationController = UINavigationController(rootViewController: viewController)

    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
}
