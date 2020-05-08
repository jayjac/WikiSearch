//
//  TestViewController.swift
//  WikiSearch
//
//  Created by Jay Jac on 5/7/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import WebKit

class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView()
        view.addSubview(webView)
        webView.frame = view.bounds
        webView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        webView.backgroundColor = .red
        let htmlString = """
<!doctype html>
<html>
<head>
<style>
body { font-size: 20pt; padding: 5px; }
.searchmatch { background-color : yellow; }
</style>
</head>
<body>
<span class="searchmatch">Nelson</span> Rolihlahla <span class="searchmatch">Mandela</span> (/mænˈdɛlə/; Xhosa: [xolíɬaɬa <span class="searchmatch">mandɛ̂ːla</span>]; 18 July 1918 – 5 December 2013) was a South African anti-apartheid revolutionary
</body>
</html>
"""

        webView.loadHTMLString(htmlString, baseURL: nil)


    }
}

extension TestViewController: WKUIDelegate {
    
    
}
