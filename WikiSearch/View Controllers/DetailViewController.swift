//
//  ResultsViewController.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/5/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let rootView: DetailScreenRootView = DetailScreenRootView()


    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
    }
    
    func loadURL(url: URL) {
        rootView.load(url: url)
    }


}
