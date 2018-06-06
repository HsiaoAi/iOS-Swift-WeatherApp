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
            return navigationController
        case .forecast:
            let forecastViewController = ColorfulNavigationController(rootViewController: UIViewController())
            forecastViewController.tabBarItem = TabBarItem(itemType: itemType)
            return forecastViewController
        }
    }
}
