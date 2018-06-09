//
//  WeatherManagerTests.swift
//  WeatherAppTests
//
//  Created by HsiaoAi on 2018/6/10.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import XCTest
@testable import WeatherApp


class WeatherManagerTests: XCTestCase {
    
    var weatherManager: WeatherManager?
    override func setUp() {
        super.setUp()
        self.weatherManager = WeatherManager.shared
    }
    
    override func tearDown() {
        self.weatherManager = nil
        super.tearDown()
    }
    
    func testFetchCurrentWeatherWithoutError() {
        self.weatherManager?.fetchCurrentWeather{ (isSucees, currentWeatherModel, error) in
            XCTAssertTrue(isSucees)
            XCTAssertTrue(currentWeatherModel != nil )
            XCTAssertTrue(error == nil)
        }
    }
    
    func testFetchForescastWithoutError() {
        self.weatherManager?.fetchThreeHoursForecast { (isSucces, cityName, lists, error) in
            XCTAssertTrue(isSucces)
            XCTAssertTrue(cityName != nil )
            XCTAssertTrue(lists != nil )
            XCTAssertTrue(error == nil)
        }
        
    }
    
}
