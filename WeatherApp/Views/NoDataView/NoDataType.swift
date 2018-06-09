//
//  NoDataType.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/7.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit


enum NoDataType {
    case noInternet, noLocation
}

extension NoDataType {
    var description: String {
        switch self {
        case .noInternet:
            return "No Internet connection found.\nCheck your connection or try again"
        case .noLocation:
            return "Let us know where are you\nso we can show you how is the weather."
        }
    }
    
    var image: UIImage {
        switch self {
        case .noInternet:
            return #imageLiteral(resourceName: "NoDataInternet")
        case .noLocation:
            return #imageLiteral(resourceName: "NoDataLocation")
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .noInternet:
            return "Reload"
        case .noLocation:
            return "Go To Settings"
        }
    }
}
