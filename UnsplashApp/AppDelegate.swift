//
//  AppDelegate.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 12.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let tabBarVC = UITabBarController()
        
        let mainVC = MainViewController()
        mainVC.tabBarItem.image = UIImage(systemName: "house")
        
        let newPostVC = NewPosTViewController()
        newPostVC.tabBarItem.image = UIImage(systemName: "plus")
        
       
        let profileVC = ProfileViewController()
        let profileVCNav = UINavigationController(rootViewController: profileVC)
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        
        tabBarVC.viewControllers = [mainVC, newPostVC, profileVCNav]
        window?.rootViewController = tabBarVC
        return true
    }
}
