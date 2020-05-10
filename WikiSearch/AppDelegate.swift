//
//  AppDelegate.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/2/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var appCoordinator: Coordinator!

    
    private func createWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
    }
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CoreDataStack.initialize { (description, err) in
            print("core data initialized")
        }
        createWindow()
        return true
    }

}

