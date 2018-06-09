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
    private let weatherManager: WeatherManager = WeatherManager()
  
    var currentLocation: CLLocation? {
        didSet {
            NotificationCenter.default.post(name: .currentLocationChanged, object: nil)
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
    
    var alertErrorMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    // MARK: Property - Closures
    var showWeatherReslut: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var updateInternetStatus: (() -> Void)?
    var updateLocationStatus: (() -> Void)?
    var showAlertClosure: (() -> Void)?

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
    
    // NARK: Get current weather
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
                if let fetchError = error! as? FecthWeatherError {
                    self.alertErrorMessage = fetchError.rawValue
                } else {
                    self.alertErrorMessage = error?.localizedDescription
                }
                return
            }
            
            guard isSucess,
                let currentWeatherModel = weather else {
                    return
            }
            
            self.currentWeatherModel = currentWeatherModel
            
            
        }
        
    }
    // MARK: Save to Firebase
    
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



