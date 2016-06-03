//
//  ZPDrawerMainController.swift
//  DrawerEffectDemo
//
//  Created by miaolin on 16/6/3.
//  Copyright © 2016年 赵攀. All rights reserved.
//

import UIKit

class ZPDrawerMainController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = UIScreen.mainScreen().bounds
        view.backgroundColor = UIColor.redColor()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ZPDrawerMainController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
}
