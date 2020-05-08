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
    
    #if DEBUG
    private func createTestWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        appCoordinator = TestAppCoordinator(window: window)
        appCoordinator.start()
    }
    #endif


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        createWindow()
        //createTestWindow()
        return true
    }

}

