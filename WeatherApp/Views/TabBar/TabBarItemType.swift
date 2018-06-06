//
//  TabBarItemType.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit

// MARK: - TabBarItemType
enum TabBarItemType {
    case today, forecast
}


extension TabBarItemType {
    
    var title: String {
        switch self {
        case .today:
            return "Today"
        case .forecast:
            return "Forecast"
        }
    }
    
    var image: UIImage {
        switch self {
        case .today:
            return  #imageLiteral(resourceName: "TodayTabBarItem").withRenderingMode(.alwaysTemplate)
        case .forecast:
            return #imageLiteral(resourceName: "ForecastTabBarItem").withRenderingMode(.alwaysTemplate)
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .today:
            return nil
        case .forecast:
            return nil
        }
    }
    
}


