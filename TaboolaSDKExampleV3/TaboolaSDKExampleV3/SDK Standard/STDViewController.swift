//
//  STDViewController.swift
//  TaboolaSDKExampleV3
//
//  Created by Liad Elidan on 22/03/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

import UIKit
import TaboolaSDK

class STDViewController: UIViewController, TaboolaSTDDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var taboolaWidgetPlacement: PlacementObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stdPage = TBLSTDPage.init(pageType: "article", pageUrl: "http://www.example.com", delegate: self, scrollView: self.collectionView)
                
        taboolaWidgetPlacement = stdPage.buildAd(withPlacementName: "Below Article", mode: "alternating-widget-without-video-1x4", placementType: PlacementTypeWidget)
        
        taboolaWidgetPlacement?.fetchContent()
    }
    
}

extension STDViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 6:
            if let taboolaWidgetPlacement = taboolaWidgetPlacement {
                let cell = taboolaWidgetPlacement.collectionView(collectionView, cellForItemAt: indexPath, withBackground: nil)
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomCell", for: indexPath)
            cell.backgroundColor = random()
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomCell", for: indexPath)
            cell.backgroundColor = random()
            return cell
        }
    }
    
    func random() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var widgetSize = CGSize(width: self.view.frame.size.width, height: 200)
        if indexPath.section == 6{
        if let taboolaSize = taboolaWidgetPlacement?.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: indexPath, withUIInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)){
            widgetSize = taboolaSize

            }
        }
        return widgetSize
    }
}
