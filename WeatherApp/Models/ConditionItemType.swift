//
//  ConditionItemType.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit

enum ConditionItemType {
    case humidity(Double), precipitation(Double), pressure(Double), windSpeed(Double), windirection(String)
}

extension ConditionItemType {
   
    var unit: String {
        switch self {
        case .humidity:
            return "%"
        case .precipitation:
            return "mm"
        case .pressure:
            return "hPa"
        case .windSpeed:
            return "km/h"
        case .windirection:
            return ""
        }
    }
    
    var image: UIImage {
        switch self {
        case .humidity:
            return #imageLiteral(resourceName: "Humidity").withRenderingMode(.alwaysTemplate)
        case .precipitation:
            return #imageLiteral(resourceName: "Precipitation").withRenderingMode(.alwaysTemplate)
        case .pressure:
            return #imageLiteral(resourceName: "Pressure").withRenderingMode(.alwaysTemplate)
        case .windSpeed:
            return #imageLiteral(resourceName: "WindSpeed").withRenderingMode(.alwaysTemplate)
        case .windirection:
            return #imageLiteral(resourceName: "WindDirection").withRenderingMode(.alwaysTemplate)
        }
    }
}


