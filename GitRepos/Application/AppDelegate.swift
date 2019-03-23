//
//  AppDelegate.swift
//  GitRepos
//
//  Created by Gilson Gil on 23/03/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = HomeViewController()
    window?.makeKeyAndVisible()
    
    return true
  }
}
