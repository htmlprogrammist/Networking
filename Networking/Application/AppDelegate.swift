//
//  AppDelegate.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let appDIContainter = AppDIContainter()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController()
        /// Dependency injecting
        viewController.networkManager = appDIContainter.start()
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
