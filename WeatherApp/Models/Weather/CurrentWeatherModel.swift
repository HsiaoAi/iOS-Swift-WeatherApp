//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/7.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//
import Foundation
import UIKit

struct CurrentWeatherModel {
    let countryAbbr: String
    var contryFullName: String?
    let cityName: String
    let temp: Double
    let main: String
    let humidity: Int
    let precipitation: Double
    let pressure: Int
    let windSppedKmpPerHour: Double
    let windDirection: String
    let dayType: DayType
    let image: UIImage
    
    init(from weatherResult: WeatherResult) {
        self.countryAbbr = weatherResult.system.country
        self.contryFullName = weatherResult.system.countryFullName
        self.cityName = weatherResult.cityName
        self.temp = weatherResult.main.temp
        self.main = weatherResult.weather.first?.main ?? ""
        self.humidity = Int(weatherResult.main.humidity)
        self.precipitation = weatherResult.rain?.precipitation ?? 0
        self.pressure = Int(weatherResult.main.pressure)
        // Default wind speed unit is meter/sec
        self.windSppedKmpPerHour = weatherResult.wind.speed * 3.6
        self.windDirection = weatherResult.wind.direction ?? ""
        self.image = weatherResult.weather.first?.image ?? UIImage()
     
        let now = Double(Date().timeIntervalSince1970)
        let sunset = weatherResult.system.sunset
        let sunrise = weatherResult.system.sunrise

        if (now > sunrise) && (now < sunset) {
            self.dayType = .day
        } else {
            self.dayType = .night
        }

    }
}

enum DayType {
    case day, night
}
