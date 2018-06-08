//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/8.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit

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
        title = TabBarItemType.forecast.title
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
            self?.title = title
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
        
        viewModel.fetchForecast()
        
    }

}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = 1
        if count == 0 {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecastLists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ForecastSectionHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45))
        view.dateLabel.text = "Today".uppercased()
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.id) as? ForecastCell else { return UITableViewCell() }
        if let list = viewModel.forecastLists?[indexPath.row] {
            cell.degreeLabel.text = "\(list.degree)°"
            cell.iconImageView.image = list.image
            cell.descriptionLabel.text = list.description
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

