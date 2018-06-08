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
        
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        let parameters: [String: String] = [
            "APPID": apiKey,
            "units": "metric",
            "lat": "\(lat)",
            "lon": "\(lon)"
        ]
        
        Alamofire.request(url,
                          method: .get,
                          parameters: parameters)
            .responseJSON { response in
                
                if let error = response.result.error {
                    completion(false, nil, error)
                    return
                }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                guard let data = response.data else {
                    completion(false, nil, nil)
                    return
                }
                                
                do {
                    let weatherResult = try decoder.decode(WeatherResult.self, from: data)
                    let currentWeatherModel = self.convertToWeatherModel(from: weatherResult)
                    self.currentWeatherModel = currentWeatherModel
                    completion(true, currentWeatherModel, nil)
                    
                } catch let error {
                    completion(false, nil, error)
                }
        }
        
        
    }
    
    func fetchThreeHoursForecast(completion: @escaping FetchForecastCompletion) {
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast") else {
            return
        }
        
        guard let lat = CLLocationManager().location?.coordinate.latitude,
            let lon = CLLocationManager().location?.coordinate.longitude else {
                NSLog("Can't get yout location")
                return
        }
        
        let parameters: [String: String] = [
            "APPID": apiKey,
            "units": "metric",
            "lat": "\(lat)",
            "lon": "\(lon)"
        ]
        
        Alamofire.request(url,
                          method: .get,
                          parameters: parameters)
            .responseJSON { response in
                if let error = response.result.error {
                    return
                }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                guard let data = response.data else {
                    return
                }
                
                do {
                    let forecastResult = try decoder.decode(ForecastResult.self, from: data)
                    let lists = forecastResult.list.map { ForecastList(list: $0) }
                    completion(true, forecastResult.city.name, lists,nil)
                    
                } catch let error {
                    print(error)
                }
                
        }
    }
    
    func convertToWeatherModel(from weatherResult: WeatherResult) -> CurrentWeatherModel {
        let weatherModel = CurrentWeatherModel(from: weatherResult)
        return weatherModel
    }
    
}
