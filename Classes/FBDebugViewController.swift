//
//  FBDebugViewController.swift
//  Trace
//
//  Created by flywithbug on 2020/7/3.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit

class FBDebugViewController: UIViewController {
    var bubble = FBDebugBubble(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: FBDebugBubble.size))
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.addSubview(self.bubble)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.bubble.updateOrientation(newSize: size)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bubble.center = FBDebugBubble.originalPosition
        self.bubble.delegate = self
        self.view.backgroundColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FBDebugWindowHelper.shared.displayedList = false
    }

    func shouldReceive(point: CGPoint) -> Bool {
        if FBDebugWindowHelper.shared.displayedList {
            return true
        }
        return self.bubble.frame.contains(point)
    }
    
}

extension FBDebugViewController: BubbleDelegate {
    
    func didTapBubble() {
        FBDebugWindowHelper.shared.displayedList = true
        let vc = FBDebugHomeViewController()
        let navc = FBDebugBaseNavigationController.init(rootViewController: vc)
        if #available(iOS 13, *) {navc.modalPresentationStyle = .fullScreen}
        self.present(navc, animated: true, completion: nil)
    }
}
