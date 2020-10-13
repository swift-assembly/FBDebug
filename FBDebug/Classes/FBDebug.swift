//
//  FBDebug.swift
//  FBDebug
//
//  Created by flywithbug on 2020/10/13.
//

import UIKit

public class FBDebug: NSObject {
    public  static func enable() {
        FBDebugWindowHelper.enable()
    }
    
    public static func disable() {
        FBDebugWindowHelper.disable()
    }
    
    public static func  registDebugPanle(_ list:[FBDebugRouterItem]) {
        FBDebugWindowHelper.shared.dataSource.append(contentsOf: list)
    }
    
}
