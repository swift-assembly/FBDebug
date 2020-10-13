//
//  FBDebugRouterItem.swift
//  FBDebug
//
//  Created by flywithbug on 2020/10/13.
//

import UIKit

public class FBDebugRouterItem: NSObject {
    public var name:String!
    public var scheme:String!
    public convenience init(_ _name:String, _scheme:String) {
        self.init()
        name = _name
        scheme = _scheme
    }
}
