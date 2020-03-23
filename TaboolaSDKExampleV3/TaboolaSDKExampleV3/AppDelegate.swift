//
//  AppDelegate.swift
//  TaboolaSDKExampleV3
//
//  Created by Liad Elidan on 10/03/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

import UIKit
import TaboolaSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Adding Taboola init to the whole application
        let publisherInfo = PublisherInfo.init(publisherName: "sdk-tester-demo")
        Taboola.initWith(publisherInfo)
        
        return true
    }

}

