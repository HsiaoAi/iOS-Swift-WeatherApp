//
//  ForecastSectionHeaderView.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/8.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit

class ForecastSectionHeaderView: UIView {
    
    static let id = "ForecastSectionHeaderView"
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ProximaNova-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    lazy var seperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Custom.seperatorColor
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    func setUpView() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18).isActive = true
        addSubview(seperator)
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        seperator.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        seperator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        self.backgroundColor = .white
    }
}
