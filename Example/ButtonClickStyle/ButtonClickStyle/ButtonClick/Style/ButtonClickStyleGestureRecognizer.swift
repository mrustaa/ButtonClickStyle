//
//  ButtonClickStyleGestureRecognizer.swift
//  ButtonLayersButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 09.03.2022.
//

import UIKit

extension ButtonClick.Style {
  
  open class GestureRecognizer: UITapGestureRecognizer {
    private var action: (UITapGestureRecognizer) -> Void
    
    public init(action: @escaping (UITapGestureRecognizer) -> Void) {
      self.action = action
      super.init(target: nil, action: nil)
      self.addTarget(self, action: #selector(execute(_:)))
    }
    
    @objc private func execute(_ sender: UITapGestureRecognizer) {
      action(sender)
    }
  }
  
}

