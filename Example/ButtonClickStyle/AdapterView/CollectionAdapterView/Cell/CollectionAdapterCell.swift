//
//  ColletionAdapterCell.swift
//  PatternsSwift
//
//  Created by mrustaa on 01/05/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

class CollectionAdapterCell: UICollectionViewCell {
    
    open var didScrollCallback: (() -> ())? = nil
  
    @IBInspectable var hideAnimation: Bool = false
    var selectedView: UIView?
    
    public var cellData: CollectionAdapterCellData?
    
    open func fill(data: Any?) {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCommonProperties()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCommonProperties()
    }
    
    private func setupCommonProperties() {
        
    }
    
    let selAlpha: CGFloat = 0.2
    
    override var isSelected: Bool {
        set {
            super.isSelected = newValue
            if hideAnimation {
                if newValue {
                  alpha = 0.5
                    UIView.animate(withDuration: 0.45, animations: {
                        self.alpha = 1
                    })
                } else {
                    self.alpha = 1
                }
            } else {
              guard let selectedView = selectedView else { return }
              if newValue {
                  selectedView.alpha = selAlpha
                  UIView.animate(withDuration: 0.45, animations: {
                      selectedView.alpha = 0.0
                  })
              } else {
                  selectedView.alpha = 0.0
              }
            }
        }
        get {
            return super.isSelected
        }
    }
    
    override var isHighlighted: Bool {
        set {
            super.isHighlighted = newValue
            if hideAnimation {
              UIView.animate(withDuration: newValue ? 0.1 : 0.45, animations: {
                self.alpha = (newValue ? 0.0 : 1.0)
              })
            } else {
                guard let selectedView = selectedView else { return }
                if newValue {
                    UIView.animate(withDuration: 0.1, animations: {
                        selectedView.alpha = self.selAlpha
                    })
                } else {
                    UIView.animate(withDuration: 0.45, animations: {
                        selectedView.alpha = 0.0
                    })
                }
            }
        }
       get { super.isHighlighted }
    }
    
}
