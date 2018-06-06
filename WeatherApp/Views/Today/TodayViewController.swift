//
//  TodayViewController.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

    @IBOutlet weak var todayTopView: TodayTopView!
    @IBOutlet weak var conditionItemLeadingContraint: NSLayoutConstraint!
    @IBOutlet weak var todayTopViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var precipitationValueLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    // MARK : Set Up
    func setUpView() {
        
        self.title = "Today"
        
        if DeviceType.phoneSE || DeviceType.phone4OrLess {
        
            todayTopViewHeightConstraint.constant = 165
            conditionItemLeadingContraint.constant = 30.5
        
        } else if DeviceType.phone8 || DeviceType.phoneX {
            
            todayTopViewHeightConstraint.constant = 167
            
            conditionItemLeadingContraint.constant = 47.0
        } else {
            
            todayTopViewHeightConstraint.constant = 180
            conditionItemLeadingContraint.constant = 70.0
            
        }
    }

}
