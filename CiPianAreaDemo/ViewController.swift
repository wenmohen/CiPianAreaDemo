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
    
//    var allData = [["type":"1","items":["",""]],["type":"2","items":["","","",""]],["type":"3","items":["","","",""]],["type":"4","items":["",""]],["type":"5","items":[""]],["type":"6","items":[""]]]
    
    var allData1 = [["type":"1","items":["",""]],["type":"2","items":["","","",""]],["type":"4","items":["",""]],["type":"6","items":[""]]]
    var allData2 = [["type":"1","items":["",""]],["type":"2","items":["","","",""]],["type":"3","items":["","","",""]],["type":"4","items":["",""]],["type":"6","items":[""]]]
    var allData3 = [["type":"1","items":["",""]],["type":"2","items":["","","",""]],["type":"3","items":["","","",""]],["type":"4","items":["",""]],["type":"5","items":[""]]]
    var allData4 = [["type":"1","items":["",""]],["type":"2","items":["","","",""]],["type":"4","items":["",""]],["type":"5","items":[""]]]
    var allData = [[String:Any]]()
    
    //优惠专区cell种类类型个数
    var favorableZoneTypeNum = 0
    //为你优选cell种类类型个数
    var optimizationTypeNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTableView()
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didRefreshButtonTouchUpInside(_ sender: Any) {
        loadData()
    }
    
}

extension ViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func loadData() {
        //瓷片区cell类型不确定，此随机显示
        var data = [allData1,allData2,allData3,allData4]
        let row = Int( Int (arc4random()) % data.count )
        allData = row > data.count - 1 ? data[0] : data[row]
        favorableZoneTypeNum = 0
        optimizationTypeNum = 0
        for i in 0..<allData.count {
            guard let type = allData[i]["type"] as? String else {
                return
            }
            let cellType = HomeActivityCellType.init(value: Int(type) ?? 1)
            switch cellType {
            case .favorableZoneTwo:
                favorableZoneTypeNum += 1
            case .favorableZoneFour:
                favorableZoneTypeNum += 1
            case .optimizationRecommendedTwo:
                optimizationTypeNum += 1
            case .optimizationSelectTwo:
                optimizationTypeNum += 1
            default:
                break
            }
        }
        
        tableView.reloadData()
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
            for i in 0..<allData.count {
                guard let type = allData[i]["type"] as? String else {
                    return height
                }
                guard let items = allData[i]["items"] as? [String] else {
                    return height
                }
                let cellType = HomeActivityCellType.init(value: Int(type) ?? 1)
                switch cellType {
                case .favorableZoneTwo:
                    let itemWidth = (width - 20 - 10)/2
                    let itemHeight = itemWidth / 175 * 110
                    let lineNum = ToCalculateCellLineNum(items: items, column: 2)
                    height += itemHeight * CGFloat(lineNum) + 10 * CGFloat(lineNum)
                case .favorableZoneFour:
                    let itemWidth = (width - 20  - 10 * 3)/4
                    let itemHeight = itemWidth / 85 * 110
                    let lineNum = ToCalculateCellLineNum(items: items, column: 4)
                    height += itemHeight * CGFloat(lineNum) + 10 * CGFloat(lineNum)
                case .optimizationRecommendedTwo:
                    let itemWidth = (width - 20  - 15)/2
                    let itemHeight = itemWidth / 172 * 137
                    let lineNum = ToCalculateCellLineNum(items: items, column: 2)
                    height += itemHeight * CGFloat(lineNum) + 10 * CGFloat(lineNum)
                case .optimizationSelectTwo:
                    let itemWidth = (width - 20  - 15)/2
                    let itemHeight = itemWidth / 172 * 119
                    let lineNum = ToCalculateCellLineNum(items: items, column: 2)
                    height += itemHeight * CGFloat(lineNum) + 10 * CGFloat(lineNum)
                case .otherAdvertOne:
                    let itemWidth = width
                    let itemHeight = itemWidth / 375 * 90
                    let lineNum = ToCalculateCellLineNum(items: items, column: 1)
                    height += itemHeight * CGFloat(lineNum) + 10 * CGFloat(lineNum)
                default:
                    let itemHeight = CGFloat( 238 )
                    let lineNum = ToCalculateCellLineNum(items: items, column: 1)
                    height += itemHeight * CGFloat(lineNum) + 10 * CGFloat(lineNum) + 35
                }
            }
           
            if favorableZoneTypeNum > 0 {
                height += CGFloat(54)
            }
            
            if optimizationTypeNum > 0 {
                height += CGFloat(54)
            }

            return height - 10
            
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
            cell.favorableZoneTypeNum = favorableZoneTypeNum
            cell.optimizationTypeNum = optimizationTypeNum
            cell.allData = allData
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


extension ViewController {
    //计算cell行数
    func ToCalculateCellLineNum(items: [String], column: Int) -> Int {
        let lineNum = CGFloat (items.count) > CGFloat(items.count / column) * CGFloat (column) ? (Int(items.count / column) + 1 )  : Int(items.count / column)
        return lineNum
    }
}
