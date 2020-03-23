//
//  WebVViewController.swift
//  TaboolaContentForApps
//
//  Created by Liad Elidan on 23/03/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

import UIKit
import WebKit

class WebVViewController: UIViewController, WKNavigationDelegate{
    var webView: WKWebView!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        let dummy_id = "Ops_Testing"
        let url = URL(string: "https://www.thestartmagazine.com/feed/summary?publisherId=" + dummy_id + "&key=0QzhwJKBfOxouyYgW3woxhwv04inkqWH&vendor=Reuters,BangShowbiz,Independent_UK&countryCode=GB&language=en")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

}
