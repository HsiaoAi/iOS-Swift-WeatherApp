//
//  Weather.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//
import UIKit

struct WeatherResult: Codable {
    
    let coordinate: Coordinate
    let weather: [Weather]
    let main: MainWeather
    let wind: Wind
    var visibility: Int?
    let system: System
    let cityName: String
    var rain: Rain?
    
    private enum CodingKeys: String, CodingKey {
        case weather, main, wind, visibility, rain
        case coordinate = "coord"
        case system = "sys"
        case cityName = "name"
    }
    
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    var icon: String
    var image: UIImage {
        return getWeatherIcon(with: icon)
    }
}

struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}

struct MainWeather: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Double
}

struct Wind: Codable {
    let speed: Double
    let degree: Double
    var direction: String? {
        return getWindDirectionAbbr(with: degree)
    }
    
    private enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
}

struct Rain: Codable {
    
    let precipitation: Double?
    
    private enum CodingKeys: String, CodingKey {
        case precipitation = "3h"
    }
}

struct System: Codable {
    let country: String
    let sunrise: Double
    let sunset: Double
    var countryFullName: String? {
        return getContryFullName(with: country)
    }
}






