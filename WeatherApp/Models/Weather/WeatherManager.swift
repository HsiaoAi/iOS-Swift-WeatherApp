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

typealias FetchCurrentWeatherCompletion = (( _ success: Bool, _ weatherResult: WeatherResult?, _ error: Error?) -> Void)


class WeatherManager {
    
    private let apiKey = "7d5d877f3fd29b0760cbf19fe3b5c670"
    static let shared = WeatherManager()
    
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
                    let weather = try decoder.decode(WeatherResult.self, from: data)
                    completion(true, weather, nil)
                    
                } catch let error {
                    print(error)
                    completion(false, nil, error)
                }
                
        }
        
        
    }
    
}
