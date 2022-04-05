//
//  XibView.swift
//  PatternsSwift
//
//  Created by mrustaa on 19/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

class XibView: UIView {
  
  // MARK: - Properties
  
  public weak var contentView: UIView?
  
  private (set) var activated = false
  
  // MARK: - Initialize
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    contentView = fromNib()
    setup()
  }
  
  public init() {
    super.init(frame: .zero)
    contentView = fromNib()
    frame = contentView?.frame ?? frame
    setup()
  }
  
  
  func activate() {
    guard !activated else { return }
    updateConstraints()
    activated = true
  }
  
  // MARK: - Load Nib
  
  func fromNibWithoutConstraints() -> UIView? {
    guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView else {
      return nil
    }
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(contentView)
    
    return contentView
  }
  
  func fromNib() -> UIView? {
    guard let contentView = fromNibWithoutConstraints() else { return nil }
    
    contentView.backgroundColor = .clear
    contentView.leftAnchor.constraint(equalTo: super.leftAnchor).isActive = true
    contentView.rightAnchor.constraint(equalTo: super.rightAnchor).isActive = true
    contentView.topAnchor.constraint(equalTo: super.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: super.bottomAnchor).isActive = true
    
    return contentView
  }
  
}

extension XibView: XibViewInitialization {
  func setup() {}
}

@objc
protocol XibViewInitialization {
  func setup()
}

