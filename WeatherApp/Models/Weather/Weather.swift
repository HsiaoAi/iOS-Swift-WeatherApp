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
    let precipitation: Double
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

func getWindDirectionAbbr(with degree: Double) -> String? {
    if (degree >= 0 && degree < 22.5) || degree == 360 {
        return "N"
    } else if degree >= 22.5 && degree < 45 {
        return "NNE"
    } else if degree >= 45 && degree < 67.5 {
        return "NE"
    } else if degree >= 67.5 && degree < 90.0 {
        return "ENE"
    } else if degree >= 90.0 && degree < 112.5 {
        return "E"
    } else if degree >= 112.5 && degree < 135 {
        return "ESE"
    } else if degree >= 135 && degree < 157.5 {
        return "SE"
    } else if degree >= 157.5 && degree < 180 {
        return "SSE"
    } else if degree >= 180 && degree < 202.5 {
        return "S"
    } else if degree >= 202.5 && degree < 225 {
        return "SSW"
    } else if degree >= 225 && degree < 247.5 {
        return "SW"
    } else if degree >= 247.5 && degree < 270 {
        return "WSW"
    } else if degree >= 270 && degree < 292.5 {
        return "W"
    } else if degree >= 292.5 && degree < 315 {
        return "WNW"
    } else if degree >= 315 && degree < 337.5 {
        return "NW"
    } else if degree >= 337.5 && degree < 360 {
        return "NNW"
    } else {
        return nil
    }
}

func getWeatherIcon(with icon: String) -> UIImage {
    switch icon {
    
    case "01d":
        return #imageLiteral(resourceName: "ClearSkyDay")
    case "01n":
        return #imageLiteral(resourceName: "ClearSkyNight")
    
    case "02d":
        return #imageLiteral(resourceName: "FewCloudsDay")
    case "02n":
        return #imageLiteral(resourceName: "FewCloudsDayNight")
        
    case "03d":
        return #imageLiteral(resourceName: "ScatteredCloudsDay")
    case "03n":
        return #imageLiteral(resourceName: "ScatteredCloudsNight")
        
    case "04d":
        return #imageLiteral(resourceName: "BrokenCloudsDay")
    case "04n":
        return #imageLiteral(resourceName: "BrokenCloudsNight")
        
    case "09d":
        return #imageLiteral(resourceName: "ShowerRainDay")
    case "09n":
        return #imageLiteral(resourceName: "ShowerRainNight")
        
    case "10d":
        return #imageLiteral(resourceName: "RainDay")
    case "10n":
        return #imageLiteral(resourceName: "RainNight")
        
    case "11d":
        return #imageLiteral(resourceName: "ThunderstormDay")
    case "11n":
        return #imageLiteral(resourceName: "ThunderstormNight")
        
    case "13d":
        return #imageLiteral(resourceName: "SnowDay")
    case "13n":
        return #imageLiteral(resourceName: "SnowNight")
        
    case "50d":
        return #imageLiteral(resourceName: "MistDay")
    case "50n":
        return #imageLiteral(resourceName: "MistNight")
    
    default:
        return UIImage()
        NSLog("cant find image")
    }
}




