//
//  CeramicsAreaModel.swift
//  iFoodMacau-Delivery
//
//  Created by ning on 2018/6/20.
//  Copyright © 2018年 Supernova Software. All rights reserved.
//

import UIKit
//import ObjectMapper
//正式
////瓷片区每个主题数据
//class CeramicsAreaModel: Mappable {
//    var title:String?
//    var subjects: [[CeramicsAreaItemModel]]?
//
//    required init?(map: Map) {
//        mapping(map: map)
//    }
//    func mapping(map: Map) {
//        title <- map["title"]
//        subjects <- map["subjects"]
//    }
//
//    func calculateItemSize(lineItems:[CeramicsAreaItemModel]) -> CGSize {
//        let width = UIScreen.main.bounds.width
//        let columnNum = lineItems.count
//        let itemWidth = columnNum > 1 ? (width - 30) / CGFloat(columnNum) - 5 : width - 30
//        //高度都和两列的一样高
//        let itemMinHeight = ((width - 30) / CGFloat(2) - 5) / 333 * 250
//        var itemHeight:CGFloat = 0
//        switch columnNum{
//        case 0:
//            itemHeight = 0
//        case 1:
//            itemHeight = itemWidth / 690 * 300
//        default:
//            itemHeight = itemMinHeight
//        }
//        return CGSize(width: itemWidth, height: itemHeight)
//    }
//}
//
////瓷片区的每个item
//class CeramicsAreaItemModel: Mappable {
//    var imageUrl:String?
//    var type:CeramicsAreaType = .unknow //類型
//    var typeString:String?{
//        didSet{
//            guard let str = typeString else { return }
//            type = CeramicsAreaType.init(string: str)
//        }
//    }
//
//    var url:String? //外鏈接
//    var merchantsId:Int? //商家Id
//    var merchantsIdString:String?{
//        didSet{
//            guard let idNumber = merchantsIdString?.intValue else { return }
//            merchantsId = idNumber
//        }
//    }
//    var menuId:Int? //分類Id
//    var menuIdString:String?{//分類Id
//        didSet{
//            guard let idNumber = menuIdString?.intValue else { return }
//            menuId = idNumber
//        }
//    }
//
//    required init?(map: Map) {
//        mapping(map: map)
//    }
//    func mapping(map: Map) {
//        typeString <- map["type"]
//        imageUrl <- map["img_url"]
//        url <- map["url"]
//        merchantsIdString <- map["merchants_id"]
//        menuIdString <- map["menu_id"]
//    }
//}

//测试
struct CeramicsAreaModel  {
    var title:String?
    var subjects: [[CeramicsAreaItemModel]]?
    
    init(title: String,subject: [[CeramicsAreaItemModel]]) {
        self.title = title
        self.subjects = subject
    }
    func calculateItemSize(lineItems:[CeramicsAreaItemModel]) -> CGSize {
        let width = UIScreen.main.bounds.width
        let columnNum = lineItems.count
        let itemWidth = columnNum > 1 ? (width - 30) / CGFloat(columnNum) - 5 : width - 30
        //高度都和两列的一样高
        let itemMinHeight = ((width - 30) / CGFloat(2) - 5) / 333 * 250
        var itemHeight:CGFloat = 0
        switch columnNum{
        case 0:
            itemHeight = 0
        case 1:
            itemHeight = itemWidth / 690 * 300
        default:
            itemHeight = itemMinHeight
        }
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}

//测试
struct CeramicsAreaItemModel {
    var image:UIImage?
    var imageUrl:String?
    var type:String?
    var typeString:String?{
        didSet{
            guard let str = typeString else { return }
            type = typeString
        }
    }
    
   
    init(image: UIImage,type: String) {
        self.image = image
        self.typeString = type
    }
}
