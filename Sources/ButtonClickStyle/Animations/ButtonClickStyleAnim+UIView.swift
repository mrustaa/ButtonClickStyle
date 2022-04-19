//
//  ButtonClickStyleAnim+UIView.swift
//  ButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 19.04.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

//MARK: - extensions

extension UIView {
  
  public func snapshot() -> UIImage {
    if #available(iOS 10.0, *) {
      let renderer = UIGraphicsImageRenderer(bounds: bounds)
      return renderer.image { rendererContext in
        layer.render(in: rendererContext.cgContext)
      }
    } else {
      UIGraphicsBeginImageContext(self.frame.size)
      self.layer.render(in:UIGraphicsGetCurrentContext()!)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return UIImage(cgImage: image!.cgImage!)
    }
  }
}
