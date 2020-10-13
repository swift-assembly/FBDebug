//
//  FBDebugRouterListViewController.swift
//  Trace
//
//  Created by flywithbug on 2020/7/6.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import FBRouter


class FBDebugRouterModel: NSObject {
    var name:String = ""
    var host:String = ""
}


class FBDebugRouterListViewController: UIViewController {

    lazy var dataSource:Array<FBDebugRouterModel> = {
        var temp:Array<FBDebugRouterModel> = []
        for item in FBRouter.router().urlMappings.keys.sorted() {
            let model:FBDebugRouterModel = FBDebugRouterModel()
            model.name = FBRouter.router().urlMappings[item] ?? ""
            model.host = item
            temp.append(model)
        }
        return temp
    }()
    
    lazy var tableView: UITableView = {
        let temp = UITableView.init(frame: self.view.bounds)
        temp.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        temp.backgroundColor = UIColor.clear
        temp.delegate = self
        temp.dataSource = self
//        temp.isScrollEnabled = false
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        self.title = "路由跳转"
        view.addSubview(self.tableView)
    }
}


extension FBDebugRouterListViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "UITableViewCell")
        }
        let model = dataSource[indexPath.row]
        cell?.textLabel?.text = model.host
        cell?.detailTextLabel?.text = model.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let model = dataSource[indexPath.row]
        self.dismiss(animated: true) {
            FBRouter.router().openHost(host: model.host)
        }
        
    }
}
