//
//  TodayViewModel.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit
import CoreLocation

class TodayViewModel: NSObject {
    
    // MARK: Property - Models
    private let networkManager: NetworkConnectionManager = NetworkConnectionManager.shared
    private let locationManager: CLLocationManager = CLLocationManager()
    private let weatherManager: WeatherManager = WeatherManager.shared
    
    var currentLocation: CLLocation? {
        didSet {
            self.fetchWeatherInformation()
        }
    }
    
    var currentWeatherModel: CurrentWeatherModel? {
        didSet {
            self.showWeatherReslut?()
        }
    }
    
    // MARK: Property - Flags
    var isGetLocation: Bool = false {
        didSet {
            self.updateLocationStatus?()
        }
    }
    
    var isConnectedNetwork: Bool = false {
        didSet {
            self.updateInternetStatus?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertOptionsMessage: String? {
        didSet {
            // Todo: Show alert
        }
    }
    
    var alertErrorMessage: String? {
        didSet {
            // Todo: Show alert
        }
    }
    
    // MARK: Property - Closures
    var showWeatherReslut: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var updateInternetStatus: (() -> Void)?
    var updateLocationStatus: (() -> Void)?


    
    
    // MARK: Init
    override init() {
        super.init()
        setUp()
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
            object: self.networkManager.reachability
        )
    }
    
    // MARK: Set Up
    func setUp() {
        locationManager.delegate = self
    }
    
    // MARK: Check location access
    @objc func checkLocationAuthorization() {
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.isGetLocation = true
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            self.isGetLocation = false
        case .notDetermined:
            self.isGetLocation = false
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    func goToAppSettingsForLocation() {
        let url = CLLocationManager.locationServicesEnabled() ? URL(string: UIApplicationOpenSettingsURLString) : URL(string: "App-Prefs:root=Privacy&path=LOCATION")
        
        UIApplication.shared.open(url!, options: [:]) { isOpen in
            if isOpen {
                self.checkLocationAuthorization()
            } else {
                NSLog("Please go to settings")
            }
        }
    }
    
    func fetchWeatherInformation() {
        
        guard let location = self.currentLocation else {
            isGetLocation = false
            self.checkLocationAuthorization()
            return
        }
        isGetLocation = true
        
        isLoading = true
        
        weatherManager.fetchCurrentWeather(with: location) { (isSucess, weather, error) in
            self.isLoading = false
            guard error == nil else {
                return
            }
            
            guard isSucess,
                let weatherResult = weather else {
                    return
            }
            self.convertToWeatherModel(from: weatherResult)
            
        }
        
    }
    
    // MARK: Get today weather
    
    // MARK: Save to Firebase
    
    // MARK: Conver WeatherResult to WeatherModel
    func convertToWeatherModel(from weatherResult: WeatherResult) {
        let weatherModel = CurrentWeatherModel(from: weatherResult)
        self.currentWeatherModel = weatherModel
    }
    
}

extension TodayViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = manager.location else { return }
        
        if let preLocation = self.currentLocation {
            if preLocation.coordinate != newLocation.coordinate {
                self.currentLocation = manager.location
            }
        }
        
        if self.currentLocation == nil {
            self.currentLocation = newLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            isGetLocation = true
        case .denied, .notDetermined, .restricted:
            isGetLocation = false
        }
    }
}

extension TodayViewModel {
    
    @objc func networkStatusChanged() {
        let status = networkManager.reachability.connection
        switch status {
        case .cellular, .wifi:
            self.isConnectedNetwork = true
            self.fetchWeatherInformation()
        case .none:
            self.isConnectedNetwork = false
        }
    }
    
}



