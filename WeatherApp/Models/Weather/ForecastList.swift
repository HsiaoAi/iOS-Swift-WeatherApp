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
        self.weedaySectionTiltes = sectionTitles
        
        var todayCount = 0
        if let firstPt = lists.first?.time {
            switch firstPt {
            case "02:00":
                todayCount = 8
            case "05:00":
                todayCount = 7
            case "08:00":
                todayCount = 6
            case "11:00":
                todayCount = 5
            case "14:00":
                todayCount = 4
            case "17:00":
                todayCount = 3
            case "20:00":
                todayCount = 2
            case "23:00":
                todayCount = 1
            default:
                break
            }
        }
        self.todayListCount = todayCount
    }
}

