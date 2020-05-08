//
//  AppCoordinator.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//
import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let searchViewController = SearchViewController()
    private let resultsViewController = ResultsViewController()
    private lazy var rootViewController: UISplitViewController = {
        let vc = UISplitViewController()
        vc.viewControllers = [self.searchViewController, self.resultsViewController]
        vc.preferredDisplayMode = .allVisible
        return vc
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}

class TestAppCoordinator: Coordinator {
    
    private let window: UIWindow

    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = TestViewController()
        window.makeKeyAndVisible()
    }
}


