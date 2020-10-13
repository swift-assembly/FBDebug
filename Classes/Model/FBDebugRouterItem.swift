//
//  FBDebugRouterItem.swift
//  FBDebug
//
//  Created by flywithbug on 2020/10/13.
//

import UIKit

class FBDebugRouterItem: NSObject {
    var name:String!
    var scheme:String!
    convenience init(_ _name:String, _scheme:String) {
        self.init()
        name = _name
        scheme = _scheme
    }
}
