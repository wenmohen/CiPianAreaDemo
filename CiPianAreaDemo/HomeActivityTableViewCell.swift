//
//  HomeActivityTableViewCell.swift
//  CiPianAreaDemo
//
//  Created by ning on 2018/6/6.
//  Copyright © 2018年 ning. All rights reserved.
//

import UIKit

class HomeActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var allData = [[String:Any]]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //优惠专区cell种类类型个数
    var favorableZoneTypeNum = 0
    //为你优选cell种类类型个数
    var optimizationTypeNum = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView() 
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension HomeActivityTableViewCell {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewFlowLayout.minimumLineSpacing = 10
        collectionViewFlowLayout.minimumInteritemSpacing = 0
    }
}

extension HomeActivityTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            guard let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ActivityHeaderCollectionReusableView", for: indexPath) as? ActivityHeaderCollectionReusableView else {
                return UICollectionReusableView()
            }
            guard let type = allData[indexPath.section]["type"] as? String else {
                return UICollectionReusableView()
            }
            let cellType = HomeActivityCellType.init(value: Int(type) ?? 1)
            
            switch cellType {
            case .favorableZoneTwo:
                headView.titleLabel.text = "优惠专区"
            case .optimizationRecommendedTwo:
                headView.titleLabel.text = "为你优选"
            case  .optimizationSelectTwo:
                headView.titleLabel.text = optimizationTypeNum == 1 ? "为你优选" : ""
            default:
                headView.titleLabel.text = ""
            }
            headView.moreButton.isHidden = cellType == .optimizationRecommendedTwo ? false : true
            return headView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = UIScreen.main.bounds.width
        guard let type = allData[section]["type"] as? String else {
            return CGSize.zero
        }
        let cellType = HomeActivityCellType.init(value: Int(type) ?? 1)
        switch cellType {
        case .favorableZoneTwo:
            return CGSize(width: width, height: 54)
        case .favorableZoneFour:
            return favorableZoneTypeNum == 1 ? CGSize(width: width, height: 54) : CGSize(width: 0, height: 0)
        case .optimizationRecommendedTwo:
            return CGSize(width: width, height: 54)
        case .optimizationSelectTwo:
            return optimizationTypeNum == 1 ? CGSize(width: width, height: 54) : CGSize(width: 0, height: 0)
        case .otherAdvertOne:
            return CGSize(width: 0, height: 0)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let type = allData[section]["type"] as? String else {
            return UIEdgeInsets.zero
        }
        let cellType = HomeActivityCellType.init(value: Int(type) ?? 1)
        switch cellType {
        case .favorableZoneTwo:
            return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        case .favorableZoneFour:
            return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        case .optimizationRecommendedTwo:
            return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        case .optimizationSelectTwo:
            return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        case .otherAdvertOne:
            return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        default:
            return UIEdgeInsets(top: 35, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        guard let type = allData[indexPath.section]["type"] as? String else {
            return CGSize.zero
        }
        let cellType = HomeActivityCellType.init(value: Int(type) ?? 1)
        switch cellType {
        case .favorableZoneTwo:
            let itemWidth = (width - 20 - 10)/2
            let itemHeight = itemWidth / 175 * 110
            return CGSize(width: itemWidth, height: itemHeight)
        case .favorableZoneFour:
            let itemWidth = (width - 20  - 10 * 3)/4
            let itemHeight = itemWidth / 85 * 110
            return CGSize(width: itemWidth, height: itemHeight)
        case .optimizationRecommendedTwo:
            let itemWidth = (width - 20  - 15)/2
            let itemHeight = itemWidth / 172 * 137
            return CGSize(width: itemWidth, height: itemHeight)
        case .optimizationSelectTwo:
            let itemWidth = (width - 20  - 15)/2
            let itemHeight = itemWidth / 172 * 119
            return CGSize(width: itemWidth, height: itemHeight)
        case .otherAdvertOne:
            let itemWidth = width
            let itemHeight = itemWidth / 375 * 90
            //            let itemHeight = CGFloat (90)
            return CGSize(width: itemWidth, height: itemHeight)
        default:
            let itemWidth = width
            let itemHeight = CGFloat (238)
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = allData[section]["items"] as? [String] else {
            return 0
        }
        return items.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return allData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let type = allData[indexPath.section]["type"] as? String else {
            return UICollectionViewCell()
        }
        let cellType = HomeActivityCellType.init(value: Int(type) ?? 1)
        switch cellType {
        case .favorableZoneTwo:
            return cellForActivityTwo(indexPath: indexPath)
        case .favorableZoneFour:
            return cellForActivityFour(indexPath: indexPath)
        case .optimizationRecommendedTwo:
            return cellForActivitySelectTwoRecommended(indexPath: indexPath)
        case .optimizationSelectTwo:
            return cellForActivitySelectTwo(indexPath: indexPath)
        case .otherAdvertOne:
            return cellForActivityOneAdvert(indexPath: indexPath)
        default:
            return cellForActivityOne(indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    /// 瓷片区-每行一栏
    ///
    /// - Parameter indexPath: indexPath
    /// - Returns: cell
    func cellForActivityOne(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityOneCollectionViewCell", for: indexPath) as? ActivityOneCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.bgImageView.image = #imageLiteral(resourceName: "icon_image16")
        cell.shopImageView.image = #imageLiteral(resourceName: "icon_image17")
        cell.shopImageView.layer.cornerRadius = cell.shopImageView.bounds.height / 2
        cell.shopGrayBgView.layer.cornerRadius = 20
        var images = [#imageLiteral(resourceName: "icon_image1"),#imageLiteral(resourceName: "icon_image2"),#imageLiteral(resourceName: "icon_image3")]
        cell.foodView1.setupFoodModel(image: images[0])
        cell.foodView2.setupFoodModel(image: images[1])
        cell.foodView3.setupFoodModel(image: images[2])
        return cell
    }
    
    /// 瓷片区-每行一栏（广告）
    ///
    /// - Parameter indexPath: indexPath
    /// - Returns: cell
    func cellForActivityOneAdvert(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityOneAdvertCollectionViewCell", for: indexPath) as? ActivityOneAdvertCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.bgImageView.image = #imageLiteral(resourceName: "img_ Placeholder6")
        return cell
    }
    
    
    /// 瓷片区-每行两栏（优惠专区）
    ///
    /// - Parameter indexPath: indexPath
    /// - Returns: cell
    func cellForActivityTwo(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityTwoCollectionViewCell", for: indexPath) as? ActivityTwoCollectionViewCell else {
            return UICollectionViewCell()
        }
        var images = [#imageLiteral(resourceName: "icon_image5"),#imageLiteral(resourceName: "icon_image6")]
        cell.bgImageView.image = indexPath.row < images.count ?  images[indexPath.row] : #imageLiteral(resourceName: "icon_image5")
        cell.leftTopButton.layer.cornerRadius = 6
        cell.leftTopButton.backgroundColor = indexPath.row == 0 ? .red : .orange
        return cell
    }
    /// 瓷片区-每行四栏（优惠专区）
    ///
    /// - Parameter indexPath: indexPath
    /// - Returns: cell
    func cellForActivityFour(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityFourCollectionViewCell", for: indexPath) as? ActivityFourCollectionViewCell else {
            return UICollectionViewCell()
        }
        var images = [#imageLiteral(resourceName: "icon_image_four1"),#imageLiteral(resourceName: "icon_image_four2"),#imageLiteral(resourceName: "icon_image_four3"),#imageLiteral(resourceName: "icon_image_four4")]
        cell.bgImageView.image = indexPath.row < images.count ?  images[indexPath.row] : #imageLiteral(resourceName: "icon_image_four1")
        return cell
    }
    /// 瓷片区-每行两栏（为你优选）
    ///
    /// - Parameter indexPath: indexPath
    /// - Returns: cell
    func cellForActivitySelectTwo(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivitySelectTwoCollectionViewCell", for: indexPath) as? ActivitySelectTwoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.bgImageView.image = indexPath.row == 0 ? #imageLiteral(resourceName: "icon_image1") : #imageLiteral(resourceName: "icon_image2")
        cell.whiteContentView.layer.cornerRadius = 5
        return cell
    }
    /// 瓷片区-每行两栏（为你优选）（推荐）
    ///
    /// - Parameter indexPath: indexPath
    /// - Returns: cell
    func cellForActivitySelectTwoRecommended(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivitySelectTwoRecommendedCollectionViewCell", for: indexPath) as? ActivitySelectTwoRecommendedCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.foodImageView.image = indexPath.row == 0 ? #imageLiteral(resourceName: "icon_image1") : #imageLiteral(resourceName: "icon_image2")
        cell.shopSmallImageView.image = indexPath.row == 0 ? #imageLiteral(resourceName: "icon_image9") : #imageLiteral(resourceName: "icon_image10")
        cell.shopSmallImageView.layer.cornerRadius = 5
        cell.shopSmallImageView.layer.masksToBounds = true
        return cell
    }
}

///MARK:--collectionViewCell及组头
/// 组头
class ActivityHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
}

/// 瓷片区-每行一栏
class ActivityOneCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var advertTagImageView: UIImageView!
    @IBOutlet weak var goBuyButton: UIButton!
    
    @IBOutlet weak var shopGrayBgView: UIView!
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var foodView1: ActivityFoodView!
    @IBOutlet weak var foodView2: ActivityFoodView!
    @IBOutlet weak var foodView3: ActivityFoodView!
}
/// 瓷片区-每行一栏（广告、内容暂定）
class ActivityOneAdvertCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgImageView: UIImageView!
}
/// 瓷片区-每行两栏（优惠专区）
class ActivityTwoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var leftTopButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
}
/// 瓷片区-每行四栏（优惠专区）
class ActivityFourCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
}
/// 瓷片区-每行两栏（评价高）（为你优选）
class ActivitySelectTwoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var whiteContentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
}

/// 瓷片区-每行两栏(推荐)（为你优选）
class ActivitySelectTwoRecommendedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var shopSmallImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
}
