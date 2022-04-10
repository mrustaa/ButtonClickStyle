//
//  AppDelegate.swift
//  ButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 05.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
//    setupWindowIfNeeded()
    
    return true
  }
  
  private func setupWindowIfNeeded() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    //    let vc = TestViewController.instantiate()
    let vc = ExampleAnimationsViewController.instantiate()
    let nav = UINavigationController(rootViewController: vc)
    nav.setNavigationBarHidden(false, animated: false)
    window.rootViewController = nav
    window.makeKeyAndVisible()
    window.tintColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    self.window = window
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

