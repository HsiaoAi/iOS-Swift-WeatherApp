//
//  CLLocationCoordinate2DExtensions.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    
    func getLatValue() -> Double {
        let latString = "\(self.latitude)"
        let value = Double( round((Double(latString)! * 1000)) / 1000 )
        return value
    }
    
    func getLonValue() -> Double {
        let lonString = "\(self.longitude)"
        let value = Double( round((Double(lonString)! * 1000)) / 1000 )
        return value
    }
}

public func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return (lhs.getLatValue() == rhs.getLatValue() && lhs.getLonValue() == rhs.getLonValue())
}



