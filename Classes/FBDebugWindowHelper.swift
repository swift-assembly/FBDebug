//
//  FBWindowHelper.swift
//  Trace
//
//  Created by flywithbug on 2020/7/3.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit



class FBDebugWindowHelper: NSObject {
    public static let shared = FBDebugWindowHelper()
    let window: FBDebugWindow
    var displayedList = false
    lazy var vc = FBDebugViewController()

    private override init() {
        self.window = FBDebugWindow(frame: UIScreen.main.bounds)
        // This is for making the window not to effect the StatusBarStyle
        self.window.bounds.size.height = UIScreen.main.bounds.height.nextDown
        super.init()
    }
    static func enable() {
        shared.enable()
    }
    public func enable() {
        if self.window.rootViewController != self.vc {
            self.window.rootViewController = self.vc
            self.window.delegate = self
            self.window.isHidden = false
        }
        FBDebugRouterManager.shared.registerURLMappings()
        
        if #available(iOS 13.0, *) {
            var success: Bool = false
            
            for i in 0...10 {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + (0.1 * Double(i))) {[weak self] in
                    if success == true {return}
                    
                    for scene in UIApplication.shared.connectedScenes {
                        if let windowScene = scene as? UIWindowScene {
                            print((0.1 * Double(i)))
                            self?.window.windowScene = windowScene
                            success = true
                        }
                    }
                }
            }
        }
    }
    
    static func disable() {
        shared.disable()
    }

    public func disable() {
        if self.window.rootViewController != nil {
            self.window.rootViewController = nil
            self.window.delegate = nil
            self.window.isHidden = true
        }
    }
}



extension FBDebugWindowHelper: FBDebugWindowDelegate {
    func isPointEvent(point: CGPoint) -> Bool {
        return self.vc.shouldReceive(point: point)
    }
    
}



