//
//  FBDebugSettings.swift
//  Trace
//
//  Created by flywithbug on 2020/7/3.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit

class FBDebugSettings: NSObject {
    @objc public static let shared = FBDebugSettings()
    @objc public var isRunning: Bool = false

    private override init() {
        bubbleFrameX = UserDefaults.standard.float(forKey: "bubbleFrameX_CocoaDebug")
        bubbleFrameY = UserDefaults.standard.float(forKey: "bubbleFrameY_CocoaDebug")
    }
    
    @objc public var bubbleFrameX: Float {
        didSet {
            UserDefaults.standard.set(bubbleFrameX, forKey: "bubbleFrameX_CocoaDebug")
            UserDefaults.standard.synchronize()
        }
    }
    
    @objc public var bubbleFrameY: Float {
        didSet {
            UserDefaults.standard.set(bubbleFrameY, forKey: "bubbleFrameY_CocoaDebug")
            UserDefaults.standard.synchronize()
        }
    }
    
}
