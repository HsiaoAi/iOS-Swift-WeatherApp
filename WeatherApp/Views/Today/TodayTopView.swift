//
//  TodayTopView.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit

class TodayTopView: UIView {
    
    let nibName = "TodayTopView"
    var contentView: UIView?
    
    
    @IBOutlet weak var centerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var informationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view

    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setUpView() {
        conditionImageView.image = #imageLiteral(resourceName: "ForecastTabBarItem")
        if DeviceType.phone4OrLess || DeviceType.phoneSE {
            
            centerViewHeightConstraint.constant = 31
        } else if DeviceType.phone8 || DeviceType.phoneX {
            
            centerViewHeightConstraint.constant = 37
        } else {
            
            centerViewHeightConstraint.constant = 50
        }
        
    }
    
}
