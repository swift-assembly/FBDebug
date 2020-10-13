//
//  FBDebug.swift
//  FBDebug
//
//  Created by flywithbug on 2020/10/13.
//

import UIKit

class FBDebug: NSObject {
    static func enable() {
        FBDebugWindowHelper.enable()
    }
    
    static func disable() {
        FBDebugWindowHelper.shared.disable()
    }
}
