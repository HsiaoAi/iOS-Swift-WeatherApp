//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

typealias FetchCurrentWeatherCompletion = (( _ success: Bool, _ weatherResult: CurrentWeatherModel?, _ error: Error?) -> Void)

typealias FetchForecastCompletion = (( _ success: Bool, _ cityName: String?, _ forecastLists: [ForecastList]?, _ error: Error?) -> Void)

class WeatherManager {
    
    private let apiKey = "7d5d877f3fd29b0760cbf19fe3b5c670"
    static let shared = WeatherManager()
    var currentWeatherModel: CurrentWeatherModel? 
    
    func fetchCurrentWeather(with location: CLLocation, completion: @escaping FetchCurrentWeatherCompletion) {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather") else {
            return
        }
        
        guard let lat = CLLocationManager().location?.coordinate.latitude,
            let lon = CLLocationManager().location?.coordinate.longitude else {
                completion(false, nil, FecthWeatherError.noLocation)
                return
        }
        
        let parameters: [String: String] = [
            "APPID": apiKey,
            "units": "metric",
            "lat": "\(lat)",
            "lon": "\(lon)"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            if let error = response.result.error {
                completion(false, nil, error)
                NSLog(error.localizedDescription)
                return
            }
            
            guard let data = response.data else {
                completion(false, nil, FecthWeatherError.noData)
                return
            }
            
            do {
                let weatherResult = try JSONDecoder().decode(WeatherResult.self, from: data)
                let currentWeatherModel = self.convertToWeatherModel(from: weatherResult)
                self.currentWeatherModel = currentWeatherModel
                completion(true, currentWeatherModel, nil)
                
            } catch let error {
                completion(false, nil, error)
                NSLog(error.localizedDescription)
            }
        }
        
    }
    
    func fetchThreeHoursForecast(completion: @escaping FetchForecastCompletion) {
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast") else {
            return
        }
        
        guard let lat = CLLocationManager().location?.coordinate.latitude,
            let lon = CLLocationManager().location?.coordinate.longitude else {
                completion(false, nil, nil, FecthWeatherError.noLocation)
                return
        }
        
        let parameters: [String: String] = [
            "APPID": apiKey,
            "units": "metric",
            "lat": "\(lat)",
            "lon": "\(lon)"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            if let error = response.result.error {
                completion(false, nil, nil, error)
                return
            }
            
            guard let data = response.data else {
                completion(false, nil, nil, FecthWeatherError.noData)
                return
            }
            
            do {
                let forecastResult = try JSONDecoder().decode(ForecastResult.self, from: data)
                let lists = forecastResult.list.map { ForecastList(list: $0) }
                completion(true, forecastResult.city.name, lists, nil)
                
            } catch let error {
                completion(false, nil, nil, error)
            }
            
        }
    }
    
    func convertToWeatherModel(from weatherResult: WeatherResult) -> CurrentWeatherModel {
        let weatherModel = CurrentWeatherModel(from: weatherResult)
        return weatherModel
    }
    
}

public enum FecthWeatherError: String, Error {
    case noLocation = "Can't get yout location location."
    case noData = "Can't get weather information of your current location."
}
