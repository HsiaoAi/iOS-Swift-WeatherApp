//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/8.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    static let id = "ForecastCell"
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    func setUpView() {
        selectionStyle = .none
    }
    
}
