//
//  UIViewControllerExtensions.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func load<VC: UIViewController>(_ type: VC.Type, from storyboard: UIStoryboard) -> VC {
        let identifier = String(describing: type)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        return controller as! VC
    }
    
}
