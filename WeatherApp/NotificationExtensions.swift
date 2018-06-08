//
//  NotificationExtensions.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let networkDisconnected = Notification.Name("networkDisconnected")
    static let appWillEnterForeground = Notification.Name("appWillEnterForeground")
    static let currentLocationChanged = Notification.Name("currentLocationChanged")

}
