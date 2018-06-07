//
//  TodayViewController.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit
import SVProgressHUD

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
    @IBOutlet weak var noInternetView: NoDataView!
    @IBOutlet weak var noLocationView: NoDataView!
    @IBOutlet var weatherIconImageViews: [UIImageView]!
    @IBOutlet weak var bottomView: UIView!
    
    
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

        title = "Today"
        noLocationView.isHidden = false
        noLocationView.setUpView(with: .noLocation)
        noLocationView.actionButton.addTarget(self, action: #selector(self.goToSettings), for: .touchUpInside)
        
        noInternetView.isHidden = false
        noInternetView.actionButton.addTarget(self, action: #selector(self.tapReload), for: .touchUpInside)
        noInternetView.setUpView(with: .noInternet)

        shareButton.addTarget(self, action: #selector(tapShareButton), for: .touchUpInside)
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
        
        viewModel.showWeatherReslut = { [weak self] in
            guard let weatherModel = self?.viewModel.currentWeatherModel else { return }
            self?.showWeatherInformation(with: weatherModel)
        }
        
        viewModel.updateLoadingStatus = { [weak self] in
            let isLoading = self?.viewModel.isLoading ?? false
            if isLoading {
                self?.showProgress(with: "Loading")
            } else {
                self?.dismissProgress()
            }
        }
        
        viewModel.updateInternetStatus = { [weak self] in
            let isConnected = self?.viewModel.isConnectedNetwork ?? false
            self?.noInternetView.isHidden = isConnected
        }
        
        viewModel.updateLocationStatus = { [weak self] in
            let isGetLocation = self?.viewModel.isGetLocation ?? false
            self?.noLocationView.isHidden = isGetLocation
        }
        
        // Call funcions
        self.viewModel.checkLocationAuthorization()
    }
    
    
    private func showWeatherInformation(with weatherModel: CurrentWeatherModel) {
        
        DispatchQueue.main.async {
            let cityName = weatherModel.cityName
            let countryName = weatherModel.contryFullName ?? weatherModel.countryAbbr
            self.todayTopView.conditionImageView.image = weatherModel.image
            self.todayTopView.locationLabel.text = "\(cityName), \(countryName)"
            self.todayTopView.informationLabel.text = "\(Int(weatherModel.temp))°C  |  \(weatherModel.main)"
            self.humidityValueLabel.text = "\(weatherModel.humidity) %"
            self.precipitationValueLabel.text = "\(weatherModel.precipitation) mm"
            self.pressureLabel.text = "\(weatherModel.pressure) hPa"
            self.windSpeedLabel.text = "\(weatherModel.windSppedKmpPerHour) km/h"
            self.windDirectionLabel.text = "\(weatherModel.windDirection)"
            
            let imageTintColor: UIColor = (weatherModel.dayType == .day) ? UIColor.Custom.weatherIconDayColor : UIColor.Custom.weatherIconNightColor
            
            // _ = self.weatherIconImageViews.map { $0.tintColor = imageTintColor }
        }
    }
    
    private func showProgress(with status: String) {
        DispatchQueue.main.async {
            SVProgressHUD.show(withStatus: status)
        }
    }
    
    private func dismissProgress() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }

}

extension TodayViewController {
    
    @objc func tapReload() {
        viewModel.fetchWeatherInformation()
    }
    
    @objc func goToSettings() {
        viewModel.goToAppSettingsForLocation()
    }
    
    @objc func tapShareButton() {
        screenShotMethod()
//        let actionViewController = UIActivityViewController(activityItems: [], applicationActivities: nil)
//        //        if let popoverPresentationController = actionViewController.popoverPresentationController {
//        //            popoverPresentationController.barButtonItem = (sender as! UIBarButtonItem)
//        //        }
//        self.present(actionViewController, animated: true, completion: nil)
    }
    
    func screenShotMethod() {
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        let width = view.frame.size.width
        let height = layer.frame.height - bottomView.bounds.height 
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return}
        layer.render(in:context)
        let screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = screenshotImage {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil )
        }
    }
}
