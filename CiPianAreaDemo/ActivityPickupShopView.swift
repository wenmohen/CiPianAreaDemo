//
//  ActivityPickupShopView.swift
//  CiPianAreaDemo
//
//  Created by ning on 2018/6/8.
//  Copyright © 2018年 ning. All rights reserved.
//

import UIKit

class ActivityPickupShopView: UIView {
    //店logo
    @IBOutlet weak var shopImageView: UIImageView!
    //店名
    @IBOutlet weak var shopNameLabel: UILabel!
    //配送费和距离所在的View
    @IBOutlet weak var middleView: UIView!
    //距离
    @IBOutlet weak var distanceLabel: UILabel!
    //配送费
    @IBOutlet weak var shippingFeeLabel: UILabel!
    ///优惠活动标签
    //第一个
    @IBOutlet weak var preferentialTagLabel1: UILabel!
    //第二个
    @IBOutlet weak var preferentialTagLabel2: UILabel!
    //第三个
    @IBOutlet weak var preferentialTagLabel3: UILabel!
    //第四个
    @IBOutlet weak var preferentialTagLabel4: UILabel!
    //第五个
    @IBOutlet weak var preferentialTagLabel5: UILabel!
    //本View点击按钮
    @IBOutlet weak var wholeShopButton: UIButton!
    //本View点击按钮响应事件
    var didWholeShopButtonClosure:(() ->())?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //点击整个View
    @IBAction func didWholeShopButtonTouchUpInside(_ sender: Any) {
        didWholeShopButtonClosure?()
    }
    
}

extension ActivityPickupShopView {
    
    func loadViewFromNib() -> ActivityPickupShopView {
        return ActivityPickupShopView.instanceFromNib(nibNameOrNil: "ActivityPickupShopView", type: ActivityPickupShopView.self) ?? ActivityPickupShopView()
    }
    
    func setupContent(model: ShopModel) {
         shopNameLabel.text = model.shopName
         shopImageView.image = model.shopIconImage
    }
}
