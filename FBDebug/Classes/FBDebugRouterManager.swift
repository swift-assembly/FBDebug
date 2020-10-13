//
//  FBDebugRouterManager.swift
//  Trace
//
//  Created by flywithbug on 2020/7/6.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import FBRouter


class FBDebugRouterManager: NSObject {
    public static let shared = FBDebugRouterManager()
    let urlMappings:Dictionary<String,String> = [
                            "debug_router_list"        :"FBDebugRouterListViewController",
            ]
    func registerURLMappings() {
        FBRouter.router().registURLMapping(urlmappings:urlMappings)
    }
      
      
    
}
