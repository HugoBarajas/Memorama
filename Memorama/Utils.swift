//
//  Utils.swift
//  Memorama
//
//  Created by Victor Hugo Barajas Santibañez on 26/02/24.
//

import Foundation
import UIKit

let width = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height

public enum Anchor {case left, top, right, bottom }

public extension UIView {
 func dropShadow(scale: Bool = true) {
  layer.masksToBounds = false
  layer.shadowColor = UIColor.gray.cgColor
  layer.shadowOpacity = 0.5
  layer.shadowOffset = CGSize(width: 1, height: 1)
  layer.shadowRadius = 1
  layer.shouldRasterize = true
  layer.rasterizationScale = scale ? UIScreen.main.scale : 1
   
 }
  
 func dropShadowColor(color : UIColor) {
  layer.masksToBounds = false
  layer.shadowColor = color.cgColor
  layer.shadowOpacity = 0.5
  layer.shadowOffset = CGSize(width: 1, height: 1)
  layer.shadowRadius = 1
  layer.shouldRasterize = true
  layer.rasterizationScale = true ? UIScreen.main.scale : 1
 }
 func addAnchorsWithMargin(_ margin: CGFloat) {
  self.translatesAutoresizingMaskIntoConstraints = false
  self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor, constant: margin).isActive = true
  self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: margin).isActive = true
  self.rightAnchor.constraint(equalTo: self.superview!.rightAnchor, constant: -margin).isActive = true
  self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: -margin).isActive = true
 }
  
 func addAnchorsCenterAndFillContainerWithSize() {
  self.translatesAutoresizingMaskIntoConstraints = false
  self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor).isActive = true
  self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor).isActive = true
  self.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor).isActive = true
  self.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor).isActive = true
 }
  
 func addAnchorsAndCenter(centerX: Bool?, centerY: Bool?, width: CGFloat?, height: CGFloat?, left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {
  self.translatesAutoresizingMaskIntoConstraints = false
  if centerX != nil {
   if centerX! == true {
    self.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor).isActive = true
   }
  }
  if centerY != nil {
   if centerY! == true {
    self.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor).isActive = true
   }
  }
   
  self.addAnchorsAndSize(width: width, height: height, left: left, top: top, right: right, bottom: bottom, withAnchor: withAnchor, relativeToView: relativeToView)
 }
 func addAnchorsAndSize(width: CGFloat?, height: CGFloat?, left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {
  self.translatesAutoresizingMaskIntoConstraints = false
  if width != nil {
   self.widthAnchor.constraint(equalToConstant: width!).isActive = true
  }
  if height != nil {
   self.heightAnchor.constraint(equalToConstant: height!).isActive = true
  }
  self.addAnchors(left: left, top: top, right: right, bottom: bottom, withAnchor: withAnchor, relativeToView: relativeToView)
 }
 func addAnchors(left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {
  self.translatesAutoresizingMaskIntoConstraints = false
  let superView = self.superview!
  if withAnchor != nil && relativeToView != nil {
   switch withAnchor! {
   case .left:
    if left != nil {
     self.leftAnchor.constraint(equalTo: relativeToView!.rightAnchor, constant: left!).isActive = true
    }
   case .top:
    if top != nil {
     self.topAnchor.constraint(equalTo: relativeToView!.bottomAnchor, constant: top!).isActive = true
    }
   case .right:
    if right != nil {
     self.rightAnchor.constraint(equalTo: relativeToView!.leftAnchor, constant: -right!).isActive = true
    }
   case .bottom:
    if bottom != nil {
     self.bottomAnchor.constraint(equalTo: relativeToView!.topAnchor, constant: -bottom!).isActive = true
    }
   }
  }
   
  if let _anchor = withAnchor {
   if _anchor == .left {
    if top != nil {
     self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
    }
    if right != nil {
     self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
    }
    if bottom != nil {
     self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
    }
   }
   if _anchor == .top {
    if left != nil {
     self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
    }
    if right != nil {
     self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
    }
    if bottom != nil {
     self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
    }
   }
   if _anchor == .right {
    if left != nil {
     self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
    }
    if top != nil {
     self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
    }
    if bottom != nil {
     self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
    }
   }
   if _anchor == .bottom {
    if left != nil {
     self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: (left!)).isActive = true
    }
    if top != nil {
     self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
    }
    if right != nil {
     self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
    }
   }
  } else {
   if left != nil {
    self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
   }
   if top != nil {
    self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
   }
   if right != nil {
    self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
   }
   if bottom != nil {
    self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
   }
  }
 }
}
struct SColors{
  static let redPrimary = UIColor(red: 209 / 255, green: 3 / 255, blue: 51 / 255, alpha: 1)
  static let pinkLow = UIColor(red: 218 / 255, green: 40 / 255, blue: 82 / 255, alpha: 1)
  static let pinkSemiWhite = UIColor(red: 243 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1)
  
  static let yellowSemiWhite = UIColor(red: 254 / 255, green: 250 / 255, blue: 238 / 255, alpha: 1)
  
  static let naranjaVista = UIColor(red: 248 / 255, green: 133 / 255, blue: 67 / 255, alpha: 1)
  
  static let grisVista = UIColor(red: 230 / 255, green: 233 / 255, blue: 229 / 255, alpha: 2)
  
  static let claro = UIColor(red: 254 / 255, green: 164 / 255, blue: 106 / 255, alpha: 1)
  
  static let grisFB = UIColor(red: 50 / 255, green: 51 / 255, blue: 53 / 255, alpha: 1)
  static let gris = UIColor(red: 174 / 255, green: 178 / 255, blue: 182 / 255, alpha: 1)
  static let negroFB = UIColor(red: 36 / 255, green: 37 / 255, blue: 39 / 255, alpha: 1)
  
  static let verde = UIColor(red: 229 / 255, green: 246 / 255, blue: 238 / 255, alpha: 1)
  
}

