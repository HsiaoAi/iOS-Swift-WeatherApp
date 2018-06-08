//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/8.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import Foundation
import UIKit

struct ForecastList {
    let sectionTitle: String
    let description: String
    let degree: Int
    let image: UIImage
    let time: String
    
    init(list: List) {
        self.description = list.weather.first?.description ?? ""
        self.image = list.weather.first?.image ?? UIImage()
        self.degree = Int(list.main.temp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:ss"
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: list.dt))
        self.time = dateString
        self.sectionTitle = ""
    }
    
}

