//
//  ColorfulNavigationController.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit

class ColorfulNavigationController: UINavigationController {
    
    // MARK: Property
    var backgroundImage = UIImage()
    let backgroundImageView = UIImageView()

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }
    
    // MARK: Set Up
    func setUpNavigationBar() {
        
        backgroundImage = #imageLiteral(resourceName: "ColorfulLineNavigationBar")
        backgroundImageView.image = backgroundImage
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
        
        navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.Custom.navigationBarTitleColor,
            NSAttributedStringKey.font: UIFont(name: "ProximaNova-Semibold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]
        
    }

}
