//
//  NoDataView.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/7.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit

class NoDataView: UIView {

    let nibName = "NoDataView"
    var contentView: UIView?
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    
    override func layoutSubviews() {
        setUpView()
    }
    
    func setUpView() {
        actionButton.layer.cornerRadius = actionButton.bounds.size.height / 2
        actionButton.clipsToBounds = true
    }
    
    func setUpView(with type: NoDataType) {
        imageView.image = type.image
        descriptionLabel.text = type.description
        actionButton.setTitle(type.buttonTitle, for: .normal)
    }

}

