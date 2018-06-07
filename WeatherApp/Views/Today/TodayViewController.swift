//
//  TodayViewController.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

    
    @IBOutlet weak var topViewHeightContraint: NSLayoutConstraint!
    // MARK: Property - IBOutlet
    @IBOutlet weak var todayTopView: TodayTopView!
    @IBOutlet weak var conditionItemLeadingContraint: NSLayoutConstraint!
    @IBOutlet weak var todayTopViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var precipitationValueLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var nodataView: NoDataView!
    
    // MARK: Property - ViewModel
    private let viewModel = TodayViewModel()
    
    
    // MARK : View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpViewModel()
    }

    // MARK : Set Up
    func setUpView() {
        
        self.title = "Today"
        self.nodataView.isHidden = true
        
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
    
    func setUpViewModel() {
        // Closures
        viewModel.hangleNodataView = { [weak self] noDataType in
            self?.showNodataView(with: noDataType)
        }
        
        
        self.viewModel.checkLocationAuthorization()
    }
    
    func showNodataView(with noDataType: NoDataType?) {
        
        guard let type = noDataType else {
            nodataView.isHidden = true
            return
        }
        
        nodataView.setUpView(with: type)
        
        switch type {
        case .noInternet:
            nodataView.actionButton.addTarget(self, action: #selector(tapReload), for: .touchUpInside)
        case .noLocation:
            nodataView.actionButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        }
        
        nodataView.isHidden = false
        
    }

}

extension TodayViewController {
    
    @objc func tapReload() {
        viewModel.fetchWeatherInformation()
    }
    
    @objc func goToSettings() {
        viewModel.goToAppSettingsForLocation()
    }
}
