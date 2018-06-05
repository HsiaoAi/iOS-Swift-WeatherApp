//
//  TabBarItem.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit

class TabBarItem: UITabBarItem {
    
    // MARK: Property
    var itemType: TabBarItemType?
    
    // MARK: Init
    init(itemType: TabBarItemType) {
        super.init()
        self.itemType = itemType
        self.title = itemType.title
        self.image = itemType.image
        self.selectedImage = itemType.selectedImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)        
    }

}
