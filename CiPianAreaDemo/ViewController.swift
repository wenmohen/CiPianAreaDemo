//
//  ViewController.swift
//  CiPianAreaDemo
//
//  Created by ning on 2018/6/5.
//  Copyright © 2018年 ning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var oneArr = [""]
    var twoArr = ["",""]
    var twoSelectArr = ["",""]
    var fourArr = ["","","",""]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 2 ? 11 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            var height: CGFloat = 0
            let width = UIScreen.main.bounds.width
            if twoArr.count >= 2 {
                let itemWidth = (width - 20 - 10)/2
                let itemHeight = itemWidth / 175 * 110
                height += itemHeight
            }
            if fourArr.count >= 4 {
                let itemWidth = (width - 20  - 10 * 3)/4
                let itemHeight = itemWidth / 85 * 110
                height += itemHeight
            }
            
            if twoArr.count >= 2 || fourArr.count >= 4 {
                height += CGFloat(64)
            }
            
            if twoArr.count >= 2 && fourArr.count >= 4 {
                height += CGFloat(10)
            }
            
            if twoSelectArr.count > 0 {
                let itemWidth = (width - 20  - 22)/2
                let itemHeight = itemWidth / 172 * 119
                height += itemHeight + CGFloat(64)
            }
            if oneArr.count > 0 {
                //            let itemWidth = width
                //            let itemHeight = itemWidth / 375 * 238
                let itemHeight = CGFloat( 238 )
                height += itemHeight + CGFloat(30)
            }
            return height
            
        }else if indexPath.section == 0{
            return 420 / 667 * view.bounds.height
        }else if indexPath.section == 2 && indexPath.row == 0{
            return 450  / 667 * view.bounds.height
        }else {
            return 130  / 667 * view.bounds.height
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeActivityTableViewCell") as? HomeActivityTableViewCell else {
                return UITableViewCell()
            }
            cell.setupCollectionView()
            return cell
        }else if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as? HomeTableViewCell else {
                return UITableViewCell()
            }
            cell.contentImageView?.image = #imageLiteral(resourceName: "icon_image_header")
            return cell
        }else if indexPath.section == 2 && indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as? HomeTableViewCell else {
                return UITableViewCell()
            }
            cell.contentImageView?.image = #imageLiteral(resourceName: "icon_image_list")
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as? HomeTableViewCell else {
                return UITableViewCell()
            }
            cell.contentImageView?.image = #imageLiteral(resourceName: "icon_image_list_item")
            return cell
            
            //            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")  else {
            //                return UITableViewCell()
            //            }
            //            cell.textLabel?.text = "列表"
            //            return cell
        }
    }
}
