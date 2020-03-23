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
        
        let taboolaWidgetCreated = TaboolaView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        taboolaWidgetCreated.delegate = self
        taboolaWidgetCreated.mode = "alternating-widget-without-video-1x4"
        taboolaWidgetCreated.publisher = "sdk-tester-demo"
        taboolaWidgetCreated.pageType = "article"
        taboolaWidgetCreated.pageUrl = "http://www.example.com"
        taboolaWidgetCreated.placement = "Below Article"
        taboolaWidgetCreated.targetType = "mix"
        taboolaWidgetCreated.setInterceptScroll(false)
        taboolaWidgetCreated.logLevel = .debug
        taboolaWidgetCreated.setOptionalModeCommands(["useOnlineTemplate": true])
        taboolaWidgetCreated.viewID = viewId
        taboolaWidget = taboolaWidgetCreated
        
        let taboolaFeedCreated = TaboolaView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        taboolaFeedCreated.delegate = self
        taboolaFeedCreated.mode = "thumbs-feed-01"
        taboolaFeedCreated.publisher = "sdk-tester-demo"
        taboolaFeedCreated.pageType = "article"
        taboolaFeedCreated.pageUrl = "http://www.example.com"
        taboolaFeedCreated.placement = "Feed without video"
        taboolaFeedCreated.targetType = "mix"
        taboolaFeedCreated.setInterceptScroll(true)
        taboolaFeedCreated.logLevel = .debug
        taboolaFeedCreated.setOptionalModeCommands(["useOnlineTemplate": true])
        taboolaFeedCreated.viewID = viewId
        taboolaFeed = taboolaFeedCreated
        
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
        print("Did fail: \(String(describing: placementName)) error: \(String(describing: error))")
    }
    
    func onItemClick(_ placementName: String!, withItemId itemId: String!, withClickUrl clickUrl: String!, isOrganic organic: Bool) -> Bool {
        return true
    }
}

