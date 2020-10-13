//
//  FBDebugHomeViewController.swift
//  Trace
//
//  Created by flywithbug on 2020/7/3.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import FBRouter

class FBDebugHomeViewController: UIViewController {

    let ScreenWidth  = UIScreen.main.bounds.width
    let ScreenHeight = UIScreen.main.bounds.height

    
    lazy var collectionView:UICollectionView = {
        // 初始化
        let itemWith = (UIScreen.main.bounds.size.width - 60) / 3

        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: itemWith, height: itemWith)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
        let temp = UICollectionView.init(frame: CGRect(x:0, y:64, width:ScreenWidth, height:self.view.bounds.size.height - 64), collectionViewLayout: layout)
        temp.backgroundColor = UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
           // 注册cell
        temp.register(FBDebugHomeCell.self, forCellWithReuseIdentifier: "FBDebugHomeCellIdentifier")
        temp.dataSource =  self
        temp.delegate = self
        
        return temp
    }()
    
    let dataSource:Array<String> = ["路由列表"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        setNaviBar()
        view.addSubview(self.collectionView)
    }
    
    
    func setNaviBar()  {
        let leftItem = UIBarButtonItem.init(title: "返回", style: .done, target: self, action: #selector(back(sender:)))
        navigationItem.leftBarButtonItem = leftItem
        navigationController?.navigationBar.barTintColor = UIColor.init(white: 0, alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.title = "调试面板"
    }
    
    @objc func back(sender:UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    
}

extension FBDebugHomeViewController:UICollectionViewDataSource,UICollectionViewDelegate{
  
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FBDebugHomeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FBDebugHomeCellIdentifier", for: indexPath) as! FBDebugHomeCell
        let temp = dataSource[indexPath.row]
        cell.setContentTitle(title: temp)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            openHostString(host: "debug_router_list")
        }
    }

    
}




