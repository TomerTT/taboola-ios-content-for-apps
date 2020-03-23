//
//  STDViewController.swift
//  TaboolaContentForApps
//
//  Created by Liad Elidan on 23/03/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

import UIKit
import TaboolaSDK

class STDViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    var taboolaWidget: TaboolaView!
    var taboolaFeed: TaboolaView!
    
    var didLoadFeed = false
    
    var taboolaWidgetHeight: CGFloat = 0.0
    
    lazy var viewId: String = {
        let timestamp = Int(Date().timeIntervalSince1970)
        return "\(timestamp)"
    }()
    
    override func viewDidLoad() {
        
        let taboolaWidget = TaboolaView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        taboolaWidget.delegate = self
        taboolaWidget.mode = "alternating-widget-without-video-1x4"
        taboolaWidget.publisher = "sdk-tester-demo"
        taboolaWidget.pageType = "article"
        taboolaWidget.pageUrl = "http://www.example.com"
        taboolaWidget.placement = "Below Article"
        taboolaWidget.targetType = "mix"
        taboolaWidget.setInterceptScroll(false)
        taboolaWidget.logLevel = .debug
        taboolaWidget.setOptionalModeCommands(["useOnlineTemplate": true])
        taboolaWidget.viewID = viewId
        
        let taboolaFeed = TaboolaView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        taboolaWidget.delegate = self
        taboolaWidget.mode = "thumbs-feed-01"
        taboolaWidget.publisher = "sdk-tester-demo"
        taboolaWidget.pageType = "article"
        taboolaWidget.pageUrl = "http://www.example.com"
        taboolaWidget.placement = "Feed without video"
        taboolaWidget.targetType = "mix"
        taboolaWidget.setInterceptScroll(true)
        taboolaWidget.logLevel = .debug
        taboolaWidget.setOptionalModeCommands(["useOnlineTemplate": true])
        taboolaWidget.viewID = viewId
        
        taboolaWidget.fetchContent()
    }
    
}

extension STDViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let taboolaIdentifier = "TaboolaCell"
        switch indexPath.section {
        case 5:
            let taboolaCell = collectionView.dequeueReusableCell(withReuseIdentifier: taboolaIdentifier, for: indexPath) as? TaboolaCollectionViewCell ?? TaboolaCollectionViewCell()
            taboolaCell.contentView.addSubview(taboolaWidget)
            return taboolaCell
        case 7:
            let taboolaCell = collectionView.dequeueReusableCell(withReuseIdentifier: taboolaIdentifier, for: indexPath) as? TaboolaCollectionViewCell ?? TaboolaCollectionViewCell()
            taboolaCell.contentView.addSubview(taboolaFeed)
            return taboolaCell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "randomCell", for: indexPath)
            cell.backgroundColor = random()
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 5:
            if taboolaWidgetHeight > 0 {
                return CGSize(width: view.frame.size.width, height: taboolaWidgetHeight)
            }
            else {
                return CGSize(width: view.frame.size.width, height: 0)
            }
        case 7:
            return CGSize(width: view.frame.size.width, height: TaboolaView.widgetHeight())
        default:
            return CGSize(width: view.frame.size.width, height: 200)
        }
    }
        
}

func random() -> UIColor {
    return UIColor(red: .random(in: 0...1),
                   green: .random(in: 0...1),
                   blue: .random(in: 0...1),
                   alpha: 1.0)
}

extension STDViewController: TaboolaViewDelegate {
    func taboolaView(_ taboolaView: UIView!, didLoadPlacementNamed placementName: String!, withHeight height: CGFloat) {
        if placementName == "Below Article"{
            taboolaWidgetHeight = height
            if !didLoadFeed {
                didLoadFeed = true
                // We are loading the feed only when the widget finished loading- for dedup.
                taboolaFeed.fetchContent()
            }
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    func taboolaView(_ taboolaView: UIView!, didFailToLoadPlacementNamed placementName: String!, withErrorMessage error: String!) {
        print("Did fail: \(placementName) error: \(error)")
    }
    
    func onItemClick(_ placementName: String!, withItemId itemId: String!, withClickUrl clickUrl: String!, isOrganic organic: Bool) -> Bool {
        return true
    }
}

