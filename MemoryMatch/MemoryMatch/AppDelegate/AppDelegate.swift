//
//  AppDelegate.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let rootView = UserDefaults.standard.bool(forKey: UserDefKeys.shared.isUserOnboarded)
        ? LoadingScreen.View(with: .init())
        : NotificationsScreen.View(with: .init())
        
        let rootViewController = NavigationBarRoot.View(with: .init(rootView: rootView))
        
        window?.rootViewController = rootViewController
        return true
    }
}

