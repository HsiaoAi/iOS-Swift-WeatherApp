//
//  TabBarController.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: Init
    
    init(itemTypes: [TabBarItemType]) {
        super.init(nibName: nil, bundle: nil)
        let viewControllers = itemTypes.map(TabBarController.prepare)
        setViewControllers(viewControllers, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    // MARK: Set Up
    private func setUpTabBar() {
        tabBar.barStyle = .default
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.Custom.tabBarItemSelectedColor
        tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font : UIFont(name: "ProximaNova-Semibold", size: 10) ?? UIFont.systemFont(ofSize: 10, weight: .semibold)], for: UIControlState())
        tabBar.unselectedItemTintColor = UIColor.Custom.tabBarItemUnSelectedColor
    }
    
}

// MARK: Prepare Item Type
extension TabBarController {
    
    // TODO: prepare the correct viewControllers
    static func prepare(for itemType: TabBarItemType) -> UIViewController {
        switch itemType {
            
        case .today:
            let todayViewController = load(TodayViewController.self, from: .today)
            let navigationController = ColorfulNavigationController(rootViewController: todayViewController)
            navigationController.tabBarItem = TabBarItem(itemType: itemType)
            navigationController.tabBarItem.accessibilityIdentifier = "TabBarItem" + itemType.title
            return navigationController
        
        case .forecast:
            let forecastViewController = load(ForecastViewController.self, from: .forecast)
            let navigationController = ColorfulNavigationController(rootViewController: forecastViewController)
            navigationController.tabBarItem = TabBarItem(itemType: itemType)
            navigationController.tabBarItem.accessibilityIdentifier = "TabBarItem" + itemType.title
            return navigationController
        
        }
    }
}
