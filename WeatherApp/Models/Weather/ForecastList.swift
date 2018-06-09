//
//  ForecastList.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/8.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import Foundation
import UIKit

struct ForecastList {
    let description: String
    let degree: Int
    let image: UIImage
    let time: String
    let weekDay: Weekday
    
    init(list: List) {
        let description = list.weather.first?.description ?? ""
        let strings = description.split(separator: " ")
        var weatherDesc = ""
        if !strings.isEmpty {
            for string in strings {
                let newString = string.prefix(1).uppercased() + string.dropFirst()
                weatherDesc += "\(newString) "
            }
        }
        self.description = weatherDesc
        self.image = list.weather.first?.image ?? UIImage()
        self.degree = Int(list.main.temp)
        let date = Date(timeIntervalSince1970: list.dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:ss"
        let dateString = dateFormatter.string(from: date)
        self.time = dateString
        let weekday = Calendar.current.component(.weekday, from: date)
        self.weekDay = Weekday(rawValue: weekday)!
    }
}

struct ForecastListsModel {
    
    let weedaySectionTiltes: [String]
    let lists: [ForecastList]
    let todayListCount: Int
    
    init(lists: [ForecastList], weekdayIndexSet: [Int]) {
        self.lists = lists
        let weedays = ["SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"]
        
        var sectionTitles = [String]()
        for index in weekdayIndexSet {
            sectionTitles.append(weedays[index])
        }
        sectionTitles[0] = "TODAY"
        print(sectionTitles)
        self.weedaySectionTiltes = sectionTitles
        let hour = lround(Double(Calendar.current.component(.hour, from: Date())) / 3.0)
        
        self.todayListCount = (8 - hour)
    }
}

