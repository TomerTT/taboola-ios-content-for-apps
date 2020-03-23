//
//  JSViewController.swift
//  TaboolaSDKExampleV3
//
//  Created by Liad Elidan on 22/03/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

import Foundation
import TaboolaSDK

class JSViewController: UIViewController, WKNavigationDelegate, TaboolaJSDelegate{
    @IBOutlet weak var webViewContainer: UIView!
    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.frame = view.frame
        webViewContainer.addSubview(webView)
        
        let jsPage =  TBLJSPage.init(delegate: self)
        jsPage.buildAd(with: webView)
                
        try? loadExamplePage()

    }
    
    func loadExamplePage() throws {
        guard let htmlPath = Bundle.main.path(forResource: "SampleHTMLPage", ofType: "html") else {
            print("Error loading HTML")
            return
        }
        let appHtml = try String.init(contentsOfFile: htmlPath, encoding: .utf8)
        webView.loadHTMLString(appHtml, baseURL: URL(string: "https://cdn.taboola.com/mobile-sdk/init/"))
    }
}
