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
    
    var currentLocation: CLLocation? {
        didSet {
            self.fetchWeatherInformation()
        }
    }
    
    // MARK: Property - Flags
    var noDataType: NoDataType? = nil {
        didSet {
            self.hangleNodataView?(noDataType)
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            // TODO: Show loading view
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
    var hangleNodataView: ((_ noDataType: NoDataType?) -> Void)?
    
    
    // MARK: Init
    override init() {
        super.init()
        setUp()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(getUserCurrentLocation),
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
    func checkLocationAuthorization() {
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            self.noDataType = nil
        case .denied, .restricted:
            self.noDataType = .noLocation
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    
    // MARK: Get user current location
    @objc func getUserCurrentLocation() {
        

    }
    
    func goToAppSettingsForLocation() {
        let url = CLLocationManager.locationServicesEnabled() ? URL(string: UIApplicationOpenSettingsURLString) : URL(string: "App-Prefs:root=Privacy&path=LOCATION")
        
        UIApplication.shared.open(url!, options: [:]) { isOpen in
            if isOpen {
                self.getUserCurrentLocation()
            } else {
                NSLog("Please go to settings")
            }
        }
    }
    
    func fetchWeatherInformation() {
        guard let location = self.currentLocation else {
            self.getUserCurrentLocation()
            return
        }
        print(location.altitude)
    }
    
    // MARK: Check connection
    func checkNetworkConnection() {
        self.networkManager.isReachable { (_ , isReachable) in
            self.noDataType = isReachable ? nil : .noInternet
        }
    }
    
    
    // MARK: Get today weather
    
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
            self.noDataType = nil
        case .denied, .notDetermined, .restricted:
            self.noDataType = .noLocation            
        }
    }
}

extension TodayViewModel {
    
    @objc func networkStatusChanged() {
        let status = networkManager.reachability.connection
        switch status {
        case .cellular, .wifi:
            self.noDataType = nil
        case .none:
            self.noDataType = .noInternet
        }
    }
    
}



