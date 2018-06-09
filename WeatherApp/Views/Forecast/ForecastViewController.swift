//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/8.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit
import SVProgressHUD

class ForecastViewController: UIViewController {

    // MARK: Property - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noInternetView: NoDataView!
    @IBOutlet weak var noLocationView: NoDataView!
    private let viewModel = ForecastViewModel()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupTableView()
        setUpViewModel()
    }
    
    // MARK : Set Up
    func setUpView() {
        
        self.navigationItem.title = TabBarItemType.forecast.title
        noInternetView.setUpView(with: .noInternet)
        noInternetView.actionButton.addTarget(self, action: #selector(tapReload), for: .touchUpInside)
        noLocationView.setUpView(with: .noLocation)
        noLocationView.actionButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)

    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.forecastCell, forCellReuseIdentifier: ForecastCell.id)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
    }
    
    func setUpViewModel() {
        viewModel.updateNaviTitle = { [weak self] title in
            self?.navigationItem.title  = title
        }
        
        viewModel.updateNoInternetView = { [weak self] in
            let isConnected = self?.viewModel.isConnectedNetwork ?? false
            self?.noInternetView.isHidden = isConnected
        }
        
        viewModel.updateNoLocationView = { [weak self] in
            let isGetLocation = self?.viewModel.isGetLocation ?? false
            self?.noLocationView.isHidden = isGetLocation
        }
        
        viewModel.updateTableView = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.updateLoadingStatus = { [weak self] in
            let isLoading = self?.viewModel.isLoading ?? false
            if isLoading {
                self?.showProgress(with: "Loading")
            } else {
                self?.dismissProgress()
            }
        }
        
        viewModel.showAlertClosure = { [weak self] in
            guard let message = self?.viewModel.alertErrorMessage else { return }
            self?.showAlert(with: message)
        }
        
        viewModel.fetchForecast()
        
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
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.forecastListModel?.weedaySectionTiltes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let total = viewModel.forecastListModel?.lists.count ?? 0
        if section == 0 {
            return viewModel.forecastListModel?.todayListCount ?? 0
        } else if (((section + 1) * 8) > total){
            return 8 - ((section + 1) * 8 - total)
        } else {
            return 8
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ForecastSectionHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45))
        view.dateLabel.text = self.viewModel.forecastListModel?.weedaySectionTiltes[section] ?? ""
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.id) as? ForecastCell else { return UITableViewCell() }
        var index = 0
        if indexPath.section == 0 {
            index = indexPath.row
        } else {
            index = (indexPath.section - 1) * 8 + indexPath.row + (viewModel.forecastListModel?.todayListCount ?? 0)
        }
        if let list = viewModel.forecastListModel?.lists[index] {
            cell.degreeLabel.text = "\(list.temp)°"
            cell.iconImageView.image = list.image
            cell.descriptionLabel.text = list.description
            cell.timeLabel.text = list.time
        }
        return cell
    }
}

extension ForecastViewController {
    
    @objc func tapReload() {
        print("reolad")
    }
    
    @objc func goToSettings() {
        goToAppSettingsForLocation()
    }
}

