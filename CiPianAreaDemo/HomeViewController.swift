//
//  HomeViewController.swift
//  CiPianAreaDemo
//
//  Created by ning on 2018/6/21.
//  Copyright © 2018年 ning. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var ceramicsAreaData = [CeramicsAreaModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HomeViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func loadData() {
        //测试数据----开始
        let subjects1 = [[CeramicsAreaItemModel.init(image: #imageLiteral(resourceName: "img_Area2"), type: "1"),CeramicsAreaItemModel.init(image: #imageLiteral(resourceName: "img_Area2"), type: "2")]]
        let subjects2 = [[CeramicsAreaItemModel.init(image: #imageLiteral(resourceName: "img_Area2"), type: "1"),CeramicsAreaItemModel.init(image: #imageLiteral(resourceName: "img_Area2"), type: "2")]]
        let subjects3 = [[CeramicsAreaItemModel.init(image: #imageLiteral(resourceName: "img_Area1"), type: "2")]]
        ceramicsAreaData = [CeramicsAreaModel.init(title: "为你优选", subject: subjects2),CeramicsAreaModel.init(title: "热门专题", subject: subjects3)]
        //测试数据----结束
        
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ceramicsAreaData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellTotalHeight:CGFloat = 0
        guard let subjects = ceramicsAreaData[indexPath.row].subjects, subjects.count > 0 else {
            return 0
        }
        for items in subjects {
            let itemSize = ceramicsAreaData[indexPath.row].calculateItemSize(lineItems: items)
            //10是每个item底部距离下一行的空间距离
            cellTotalHeight += itemSize.height + 10
        }
        //60是每个主题的高度
        cellTotalHeight += 60
        return cellTotalHeight
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CeramicsAreaTableViewCell.className) as? CeramicsAreaTableViewCell else {
            return UITableViewCell()
        }
        cell.ceramicsAreaThemeData = ceramicsAreaData[indexPath.row]
        cell.didSelectItemClosure = { [weak self] (itemModel: CeramicsAreaItemModel?) in
            guard let model = itemModel else { return }
            
        }
        return cell
    }
}
