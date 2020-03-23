//
//  JSViewController.swift
//  TaboolaContentForApps
//
//  Created by Liad Elidan on 23/03/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

import UIKit
import WebKit
import TaboolaSDK

class JSViewController: UIViewController {
    @IBOutlet weak var webViewContainer: UIView!
    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = view.frame
        webViewContainer.addSubview(webView)
        TaboolaJS.sharedInstance()?.logLevel = .debug
        TaboolaJS.sharedInstance()?.registerWebView(webView, with: self)
        // Do any additional setup after loading the view.
        try? loadExamplePage()
    }
    
    func loadExamplePage() throws {
        guard let htmlPath = Bundle.main.path(forResource: "JSSamplePage", ofType: "html") else {
            print("Error loading HTML")
            return
        }
        let appHtml = try String.init(contentsOfFile: htmlPath, encoding: .utf8)
        webView.loadHTMLString(appHtml, baseURL: URL(string: "https://cdn.taboola.com/mobile-sdk/init/"))
    }
}

extension JSViewController: TaboolaJSDelegate {
    func onItemClick(_ placementName: String!, withItemId itemId: String!, withClickUrl clickUrl: String!, isOrganic organic: Bool) -> Bool {
        return true
    }
}
