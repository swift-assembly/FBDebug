//
//  FBDebugBubble.swift
//  Trace
//
//  Created by flywithbug on 2020/7/3.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass


protocol BubbleDelegate: class {
    func didTapBubble()
}


private let _width: CGFloat = 60
private let _height: CGFloat = 60


class FBDebugBubble: UIView {
    
    
    var hasPerformedSetup: Bool = false//liman

    weak var delegate: BubbleDelegate?


    private lazy var numberLabel: FBDebugFPSLabel? = {
        return FBDebugFPSLabel(frame: CGRect(x:0, y:0, width:_width, height:_height))
    }()
    private var networkNumber: Int = 0
    
    static var originalPosition: CGPoint {
        if FBDebugSettings.shared.bubbleFrameX != 0 && FBDebugSettings.shared.bubbleFrameY != 0 {
            return CGPoint(x: CGFloat(FBDebugSettings.shared.bubbleFrameX), y: CGFloat(FBDebugSettings.shared.bubbleFrameY))
        }
        return CGPoint(x: 1.875 + _width/2, y: 200)
    }
      
    static var size: CGSize {return CGSize(width: _width, height: _height)}

      fileprivate func initLayer() {
          self.backgroundColor = .black
          self.layer.shadowColor = UIColor.black.cgColor
          self.layer.shadowRadius = 5
          self.layer.shadowOpacity = 0.8
          self.layer.cornerRadius = 10
          self.layer.shadowOffset = CGSize.zero
          self.layer.masksToBounds = true
          self.sizeToFit()
          
          let gradientLayer = CAGradientLayer()
          gradientLayer.frame = bounds
          gradientLayer.cornerRadius = 10
          gradientLayer.colors = [UIColor(red:0.25, green:0.25, blue:0.25, alpha:1.00).cgColor,
          UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.00).cgColor]
          self.layer.addSublayer(gradientLayer)
          
          
          if let numberLabel = numberLabel {
              self.addSubview(numberLabel)
          }
          
          
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FBDebugBubble.tap))
          self.addGestureRecognizer(tapGesture)
          
          let longTap = UILongPressGestureRecognizer.init(target: self, action: #selector(FBDebugBubble.longTap))
          self.addGestureRecognizer(longTap)
      }
      
      func changeSideDisplay() {
          UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5,
                         initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
          }, completion: nil)
      }
      
      func updateOrientation(newSize: CGSize) {
          let oldSize = CGSize(width: newSize.height, height: newSize.width)
          let percent = center.y / oldSize.height * 100
          let newOrigin = newSize.height * percent / 100
          let originX = frame.origin.x < newSize.height / 2 ? _width/8*4.25 : newSize.width - _width/8*4.25
          self.center = CGPoint(x: originX, y: newOrigin)
      }
      
      //MARK: - init
      override init(frame: CGRect) {
          super.init(frame: frame)
          initLayer()
          
          //添加手势
          let selector = #selector(FBDebugBubble.panDidFire(panner:))
          let panGesture = UIPanGestureRecognizer(target: self, action: selector)
          self.addGestureRecognizer(panGesture)
          
      }
      
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      deinit {
          //notification
          NotificationCenter.default.removeObserver(self)
      }

      
      //MARK: - target action
      @objc func tap() {
          delegate?.didTapBubble()
      }
      
      @objc func longTap() {
          
      }
      
      @objc func panDidFire(panner: UIPanGestureRecognizer) {
          if panner.state == .began {
              UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: { [weak self] in
                  self?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                  }, completion: nil)
          }
          
          let offset = panner.translation(in: self.superview)
          panner.setTranslation(CGPoint.zero, in: self.superview)
          var center = self.center
          center.x += offset.x
          center.y += offset.y
          self.center = center
          
          if panner.state == .ended || panner.state == .cancelled {
              let frameInset: UIEdgeInsets = UIDevice.current.orientation.isPortrait ? UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0) : .zero
              let location = panner.location(in: self.superview)
              let velocity = panner.velocity(in: self.superview)
              
            var finalX: Double = Double(self.bounds.size.width/8*4.25)
              var finalY: Double = Double(location.y)
              
              if location.x > UIScreen.main.bounds.size.width / 2 {
                  finalX = Double(UIScreen.main.bounds.size.width) - Double(self.bounds.size.width/8*4.25)
              }
              
              self.changeSideDisplay()
              
              let horizentalVelocity = abs(velocity.x)
              let positionX = abs(finalX - Double(location.x))
              
              let velocityForce = sqrt(pow(velocity.x, 2) * pow(velocity.y, 2))
              
              let durationAnimation = (velocityForce > 1000.0) ? min(0.3, positionX / Double(horizentalVelocity)) : 0.3
              
              if velocityForce > 1000.0 {
                  finalY += Double(velocity.y) * durationAnimation
              }
              
              if finalY > Double(UIScreen.main.bounds.size.height) - Double(self.bounds.size.height/8*4.25) {
                  finalY = Double(UIScreen.main.bounds.size.height) - Double(frameInset.bottom) - Double(self.bounds.size.height/8*4.25)
              } else if finalY < Double(self.bounds.size.height/8*4.25) + Double(frameInset.top)  {
                  finalY = Double(self.bounds.size.height/8*4.25) + Double(frameInset.top)
              }
              
              UIView.animate(withDuration: durationAnimation * 5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 6, options: .allowUserInteraction, animations: { [weak self] in
                  self?.center = CGPoint(x: finalX, y: finalY)
                  self?.transform = CGAffineTransform.identity
                  }, completion: { _ in
                      FBDebugSettings.shared.bubbleFrameX = Float(finalX)
                      FBDebugSettings.shared.bubbleFrameY = Float(finalY)
              })
          }
      }

    
    
    
    
}
