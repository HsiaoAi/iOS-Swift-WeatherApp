//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/8.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class ForecastViewModel {
    
    // MARk: Property
    let weatherManager = WeatherManager.shared
    
    var forecastLists: [ForecastList]? {
        didSet {
            self.updateTableView?()
        }
    }
   
    var currentCity: String? {
        didSet {
            guard let cityName = currentCity else {
                return
            }
            self.updateNaviTitle?(cityName)
        }
    }
    
    var isGetLocation: Bool = false {
        didSet {
            self.updateNoLocationView?()
        }
    }
    
    var isConnectedNetwork: Bool = false {
        didSet {
            self.updateNoInternetView?()
        }
    }
    
    // MARK: Property - Closures
    var updateNaviTitle: ((_ title: String) -> Void)?
    var updateNoInternetView: (() -> Void)?
    var updateNoLocationView: (() -> Void)?
    var updateTableView: (() -> Void)?

    
    // MARK: Init
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkLocationAuthorization),
            name: .appWillEnterForeground,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged),
            name: .reachabilityChanged,
            object: nil
        )
            
    }
    
    func fetchForecast() {
        weatherManager.fetchThreeHoursForecast { (isSucess, cityName, forecastLists, error) in
            self.currentCity = cityName
            self.forecastLists = forecastLists
        }
    }

    
}

extension ForecastViewModel {
   
    @objc func currentCityChanged() {
        self.currentCity = WeatherManager.shared.currentWeatherModel?.cityName ?? ""
    }
    
    @objc func checkLocationAuthorization() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.isGetLocation = true
        default:
            self.isGetLocation = false
        }
    }
    
    @objc func networkStatusChanged() {
        let status = NetworkConnectionManager.shared.reachability.connection
        switch status {
        case .cellular, .wifi:
            self.isConnectedNetwork = true
        case .none:
            self.isConnectedNetwork = false
        }
    }
    
}

