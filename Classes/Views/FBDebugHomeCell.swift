//
//  FBDebugHomeCell.swift
//  Trace
//
//  Created by flywithbug on 2020/7/6.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit

class FBDebugHomeCell: UICollectionViewCell {
    
    lazy var label:UILabel = {
        let temp = UILabel.init(frame: self.bounds)
        temp.textAlignment = NSTextAlignment.center
        temp.textColor = UIColor.init(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1)
        temp.font = UIFont.boldSystemFont(ofSize: 15)
        return temp
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubViews()
        self.contentView.backgroundColor = UIColor.white
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.3
        self.contentView.layer.shadowRadius = 4
        self.contentView.layer.shadowOffset = CGSize.init(width: 4, height: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setSubViews()  {
        contentView.addSubview(self.label)
    }
    
    func setContentTitle(title:String)  {
        label.text = title
    }
}
