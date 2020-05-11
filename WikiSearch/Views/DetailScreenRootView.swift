//
//  DetailScreenRootView.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/9/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import WebKit

class DetailScreenRootView: UIView {

    
    private let webView: WKWebView
    
    required init?(coder: NSCoder) {
        fatalError("Should not be created from IB")
    }
    
    init() {
        webView = WKWebView()
        super.init(frame: .zero)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(webView)
        webView.frame = bounds
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func load(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }

}
