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
    
    var forecastListModel: ForecastListsModel? {
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
    var updateNaviTitle: ((_ title: String) -> Void)?
    var updateNoInternetView: (() -> Void)?
    var updateNoLocationView: (() -> Void)?
    var updateTableView: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var showAlertClosure: (() -> Void)?

    
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
        isLoading = true
        weatherManager.fetchThreeHoursForecast { (isSucess, cityName, forecastLists, error) in
            self.isLoading = false
            
            if let error = error {
                
                if let fetchError = error as? FecthWeatherError {
                    self.alertErrorMessage = fetchError.rawValue
                } else {
                    self.alertErrorMessage = error.localizedDescription
                }

            } else if isSucess {
                
                self.currentCity = cityName
                guard let weekdayIndex = self.sortForecastModels() else { return }
                guard let lists = forecastLists else { return }
                let forecastListsModel = ForecastListsModel(lists: lists, weekdayIndexSet: weekdayIndex)
                self.forecastListModel = forecastListsModel
                
            }
        }
    }
    
    func sortForecastModels() -> [Int]? {
        guard let todayWeekDay = Weekday(rawValue: Calendar.current.component(.weekday, from: Date())) else { return nil }
        
        var weekDayIndex = [todayWeekDay.rawValue - 1]
        for index in 1...4 {
            let nextWeekday = (index + todayWeekDay.rawValue - 1 ) % 7
            weekDayIndex.append(nextWeekday)
        }
        return weekDayIndex
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

