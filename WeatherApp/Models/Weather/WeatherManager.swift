//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import Foundation

typealias FetchCurrentWeatherCompletion = ( _ success: Bool, _ weatherResult: Weather?, _ error: Error?) -> Void


class WeatherManager {
    private let apiKey = "7d5d877f3fd29b0760cbf19fe3b5c670"
    static let shared = WeatherManager()
    
    
}
