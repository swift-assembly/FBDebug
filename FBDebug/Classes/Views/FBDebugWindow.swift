//
//  FBDebugWindow.swift
//  Trace
//
//  Created by flywithbug on 2020/7/3.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit



protocol FBDebugWindowDelegate: class {
    func isPointEvent(point: CGPoint) -> Bool
}

class FBDebugWindow: UIWindow {

    weak var delegate: FBDebugWindowDelegate?

   override init(frame: CGRect) {
       super.init(frame: frame)
       self.backgroundColor = .clear
       self.windowLevel = UIWindow.Level(rawValue: UIWindow.Level.alert.rawValue - 1)
   }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

   override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
       return self.delegate?.isPointEvent(point: point) ?? false
   }
    
}
