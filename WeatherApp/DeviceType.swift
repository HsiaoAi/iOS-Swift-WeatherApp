//
//  GlobalFunctions.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit

public struct DeviceType{
    
    public static let phone4OrLess  = UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.height < 568.0
    
    public static let phoneSE = UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.width == 320.0
    
    public static let phone8  = UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.width == 375.0
    
    public static let phone8S = UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.width == 414.0
    
    public static let phoneX = UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.width == 375.0
    
    public static let pad = UIDevice.current.userInterfaceIdiom == .pad

}
