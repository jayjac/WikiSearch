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
    private let detailViewController = DetailViewController()
    private lazy var rootViewController: UISplitViewController = {
        let vc = UISplitViewController()
        vc.viewControllers = [self.searchViewController, self.detailViewController]
        vc.preferredDisplayMode = .allVisible
        return vc
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = rootViewController
        searchViewController.searchResultDelegate = self
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: SearchResultViewModelDelegate {
    func openSearchResultURL(url: URL) {
        detailViewController.loadURL(url: url)
        rootViewController.show(detailViewController, sender: nil)
    }
}






