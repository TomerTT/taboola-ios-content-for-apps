//
//  TaboolaCollectionViewCell.swift
//  TaboolaContentForApps
//
//  Created by Liad Elidan on 23/03/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

import UIKit

class TaboolaCollectionViewCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
    }
}
