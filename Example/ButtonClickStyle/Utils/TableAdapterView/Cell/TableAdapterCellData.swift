//
//  TableAdapterCellData.swift
//  PatternsSwift
//
//  Created by mrustaa on 17/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit


open class TableAdapterCellData: NSObject {

    // MARK: Properties

    open var separatorVisible: Bool = false
    open var touchAnimationHide: Bool = false
    open var editing: Bool = false
    open var cellClickCallback: (() -> ())?

    // MARK: Init
    
    init(_ separator: Bool? = false,
         _ touchAnimationHide: Bool? = false,
         _ editing: Bool? = false,
         _ clickCallback: (() -> ())? = nil) {
    
        self.separatorVisible = separator ?? false
        self.touchAnimationHide = touchAnimationHide ?? false
        self.editing = editing ?? false
        self.cellClickCallback = clickCallback
    }

    // MARK: Methods
  
    open func calculateLabel(text: String?, font: UIFont? = nil, x: CGFloat = 16.0) -> CGFloat {
      type(of: self).classCalculateLabel(text: text, font: font, x: x).height
    }
    
    open class func classCalculateLabel(text: String?, font: UIFont? = nil, lines: Int = 99, x: CGFloat = 16.0) -> CGRect {
      if let text = text {
          let titleLabel = UILabel(frame: CGRect(x: x, y: 0, width: (UIScreen.main.bounds.size.width - (x * 2)), height: 10))
        titleLabel.tag = 0
        titleLabel.font = font ?? UIFont.systemFont(ofSize: 18)
        titleLabel.text = text
        titleLabel.numberOfLines = lines
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
          
          return titleLabel.frame
      } else {
        return .zero
      }
    }
  
  
  open func calculateLabelClassic(
    text: String?
  ) -> CGFloat {
    return type(of: self).calculateLabelCls(text: text, padding: 16, titleFont: UIFont.systemFont(ofSize: 18))
  }
  
  open func calculateLabel(
    text: String?,
    padding: CGFloat? = nil,
    percent: CGFloat? = nil,
    fixedWidth: CGFloat? = nil,
    titleFont: UIFont? = nil
  ) -> CGFloat {
    return type(of: self).calculateLabelCls(text: text, padding: padding, titleFont: titleFont)
  }
  
    class func calculateLabelCls(
      text: String?,
      padding: CGFloat? = nil,
      percent: CGFloat? = nil,
      fixedWidth: CGFloat? = nil,
      titleFont: UIFont? = nil,
      numberOfLines: Int = 99
    ) -> CGFloat {
      
      if let text = text {
        
        var width: CGFloat = 0
        if let padding = padding {
          width = (UIScreen.main.bounds.size.width - (padding * 2))
        }
        if let percent = percent {
          width = (UIScreen.main.bounds.size.width * percent)
        }
        if let fixedWidth = fixedWidth {
          width = fixedWidth
        }
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 10))
          titleLabel.tag = 0
        titleLabel.font = titleFont ?? UIFont.systemFont(ofSize: 18)
          titleLabel.text = text
          titleLabel.numberOfLines = numberOfLines
          titleLabel.textAlignment = .center
          titleLabel.sizeToFit()
        
        return titleLabel.frame.height
      } else {
        return 0
      }
    }
  
    open func cellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }

    open func canEditing() -> Bool {
        return false
    }
    
    open func equals(compareTo data: TableAdapterCellData) -> Bool {
        return false
    }
    
    open func dataStr() -> String {
      return ""
    }
}
