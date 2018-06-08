//
//  ForecastResult.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/8.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import Foundation

struct ForecastResult: Codable {
    let cnt: Int
    let list: [List]
    let city: City
}

struct List: Codable {
    let dt: Double
    let main: MainWeather
    let weather: [Weather]
    let clouds: Clound?
    let wind: Wind
    let snow: Snow?
    let rain: Rain?
}

struct Clound: Codable {
    let all: Double
}

struct Snow: Codable {
    let threeHoursValue: Double
    
    private enum CodingKeys: String, CodingKey {
        case threeHoursValue = "3h"
    }
}

struct City: Codable {
    let id: Int
    let name: String
    let country: String
    var countryFullName: String? {
        return getContryFullName(with: self.country)
    }
}

