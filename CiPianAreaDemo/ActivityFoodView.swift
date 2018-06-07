//
//  ActivityFoodView.swift
//  CiPianAreaDemo
//
//  Created by nhl on 2018/6/6.
//  Copyright © 2018年 ning. All rights reserved.
//

import UIKit

class ActivityFoodView: UIView {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var hotRecommendedLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     */
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    @IBAction func didButtonTouchUpInside(_ sender: Any) {
        print("这里")
    }
}

extension ActivityFoodView {
    //这种方式主要用于此自定义的xib view可以直接在Stroyboard中使用
    func loadViewFromNib() {
        guard let view = UINib.init(nibName: "ActivityFoodView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).last as? UIView else {
            return
        }
        self.myView = view
        self.myView.frame = bounds
        self.myView.frame.size.width = (UIScreen.main.bounds.width - 20) / 3
        addSubview(self.myView)
        setupView()
    }
    
    func setupView() {
        foodImageView.layer.cornerRadius = foodImageView.bounds.width / 2
        hotRecommendedLabel.layer.borderColor = UIColor.orange.cgColor
        hotRecommendedLabel.layer.borderWidth = 1.5
    }
    
    func setupFoodModel(image: UIImage) {
        loadViewFromNib()
        foodImageView.image = image
    }
}
