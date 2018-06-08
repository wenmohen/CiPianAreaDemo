//
//  foodModel.swift
//  CiPianAreaDemo
//
//  Created by nhl on 2018/6/7.
//  Copyright © 2018年 ning. All rights reserved.
//

import UIKit
//商品
struct FoodModel  {
    var foodName: String?
    var foodImage: UIImage = UIImage()
    var price: String?
    var originalPrice: String?
    
    init(foodName: String,foodImage: UIImage,price: String) {
        self.foodName = foodName
        self.foodImage = foodImage
        self.price = "￥" + price
    }
}

//商铺
struct ShopModel {
    var shopName: String?
    var shopIconImage: UIImage = UIImage()
    var distance: String?
    init(shopName: String,shopIconImage: UIImage) {
        self.shopName = shopName
        self.shopIconImage = shopIconImage
    }
}
enum HomeActivityCellType: String {
    ///优惠专区
    //优惠专区：一行两栏
    case favorableZoneTwo = "1"
    //优惠专区：一行四栏
    case favorableZoneFour = "2"
    ///为你优选
    //为你优选：一行两栏（推荐）
    case optimizationRecommendedTwo = "3"
    //为你优选：一行两栏（精选/好评）
    case optimizationSelectTwo = "4"
    ///其它
    //一行一栏，广告图
    case otherAdvertOne = "5"
    //一行一栏，某个店热卖推荐
    case otherRecommendedOne = "6"
    //到店自取
    //一行一栏，可以横向滚动
    case goShopPickupOne = "7"
    
    init(value: Int) {
        switch value {
        case 1:
            self = .favorableZoneTwo
        case 2:
            self = .favorableZoneFour
        case 3:
            self = .optimizationRecommendedTwo
        case 4:
            self = .optimizationSelectTwo
        case 5:
            self = .otherAdvertOne
        case 6:
            self = .otherRecommendedOne
        default:
            self = .goShopPickupOne
        }
    }
    
}
