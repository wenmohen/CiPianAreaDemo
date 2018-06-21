//
//  CeramicsAreaTableViewCell.swift
//  iFoodMacau-Delivery
//
//  Created by ning on 2018/6/20.
//  Copyright © 2018年 Supernova Software. All rights reserved.
//

import UIKit

class CeramicsAreaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    //每个主题数据
    var ceramicsAreaThemeData:CeramicsAreaModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var didSelectItemClosure:((_ itemModel:CeramicsAreaItemModel?) -> ())?

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

extension CeramicsAreaTableViewCell {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewFlowLayout.minimumLineSpacing = 10
        collectionViewFlowLayout.minimumInteritemSpacing = 5
    }
}
extension CeramicsAreaTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader && indexPath.section == 0 {
            guard let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CeramicsAreaHeaderCollectionReusableView.className, for: indexPath) as? CeramicsAreaHeaderCollectionReusableView else {
                return UICollectionReusableView()
            }
            guard let title = ceramicsAreaThemeData?.title else {
                return UICollectionReusableView()
            }
            headView.titleLabel.text = title
            return headView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let sectionSize = section == 0 ? CGSize(width: UIScreen.main.bounds.width, height: 60) : CGSize.zero
        return sectionSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let subjects = ceramicsAreaThemeData?.subjects, subjects.count > 0 else {
            return CGSize.zero
        }
        return ceramicsAreaThemeData?.calculateItemSize(lineItems: subjects[indexPath.section]) ?? CGSize.zero
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = ceramicsAreaThemeData?.subjects, items.count > 0,items[section].count > 0 else {
            return 0
        }
        return items[section].count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let items = ceramicsAreaThemeData?.subjects, items.count > 0 else {
            return 0
        }
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CeramicsAreaCollectionViewCell.className, for: indexPath) as? CeramicsAreaCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let subjects = ceramicsAreaThemeData?.subjects, subjects.count > 0,subjects[indexPath.section].count > 0  else { return cell }
        cell.setupContent(model: subjects[indexPath.section][indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        guard let subjects = ceramicsAreaThemeData?.subjects, subjects.count > 0,subjects[indexPath.section].count > 0  else { return }
        didSelectItemClosure?(subjects[indexPath.section][indexPath.row])
    }
}
/// 组头
class CeramicsAreaHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
}

/// 瓷片区cell
class CeramicsAreaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgContentView: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
    func setupContent(model: CeramicsAreaItemModel) {
        bgImageView.image = model.image
    }
}

