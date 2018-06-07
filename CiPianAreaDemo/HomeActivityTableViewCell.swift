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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
    }
}

extension HomeActivityTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            guard let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ActivityHeaderCollectionReusableView", for: indexPath) as? ActivityHeaderCollectionReusableView else {
                return UICollectionReusableView()
            }
            if indexPath.section == 0 || indexPath.section == 2 {
                headView.titleLabel.text = indexPath.section == 0 ? "优惠专区" : "为你优选"
            }else {
                headView.titleLabel.text = ""
            }
            return headView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = UIScreen.main.bounds.width
        switch section {
        case 0:
            return CGSize(width: width, height: 54)
        case 1:
            return CGSize(width: 0, height: 0)
        case 2:
            return CGSize(width: width, height: 54)
        default:
            return CGSize(width: width, height: 20)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        case 1:
            return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        case 2:
            return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        default:
            return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        switch indexPath.section {
        case 0:
            let itemWidth = (width - 20 - 10)/2
            let itemHeight = itemWidth / 175 * 110
            return CGSize(width: itemWidth, height: itemHeight)
        case 1:
            let itemWidth = (width - 20  - 10 * 3)/4
            let itemHeight = itemWidth / 85 * 110
            return CGSize(width: itemWidth, height: itemHeight)
        case 2:
            let itemWidth = (width - 20  - 15)/2
            let itemHeight = itemWidth / 172 * 119
            return CGSize(width: itemWidth, height: itemHeight)
        default:
            let itemWidth = width
            //            let itemHeight = itemWidth / 375 * 238
            let itemHeight = CGFloat (238)
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 4
        case 2:
            return 2
        default:
            return 1
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return cellForActivityTwo(indexPath: indexPath)
        case 1:
            return cellForActivityFour(indexPath: indexPath)
        case 2:
            return cellForActivitySelectTwo(indexPath: indexPath)
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
        cell.foodView1.setupFoodModel(image: images[indexPath.row])
        cell.foodView2.setupFoodModel(image: images[indexPath.row])
        cell.foodView3.setupFoodModel(image: images[indexPath.row])
        
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
        cell.bgImageView.image = images[indexPath.row]
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
        cell.bgImageView.image = images[indexPath.row]
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
}

///MARK:--collectionViewCell及组头
/// 组头
class ActivityHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
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
/// 瓷片区-每行两栏（为你优选）
class ActivitySelectTwoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var whiteContentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
}
