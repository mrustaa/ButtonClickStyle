
import UIKit

//MARK: - Round
extension UIView {
    
    public func set(x:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    
   public func set(y:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    
   public func set(width:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
    
   public func set(height:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.height = height
        self.frame = frame
    }
}

extension CALayer {
    
   public func set(x:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    
   public func set(y:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    
   public func set(width:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
    
    public func set(height:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.height = height
        self.frame = frame
    }
}

extension UIView {
  
  // MARK: - Basic Properties
  
  /// X Axis value of UIView.
  public var xx: CGFloat {
    set { self.frame = CGRect(x: _pixelIntegral(newValue),
                              y: self.yy,
                              width: self.wwidth,
                              height: self.hheight)
    }
    get { return self.frame.origin.x }
  }
  
  /// Y Axis value of UIView.
  public var yy: CGFloat {
    set { self.frame = CGRect(x: self.xx,
                              y: _pixelIntegral(newValue),
                              width: self.wwidth,
                              height: self.hheight)
    }
    get { return self.frame.origin.y }
  }
  
  /// Width of view.
  public var wwidth: CGFloat {
    set { self.frame = CGRect(x: self.xx,
                              y: self.yy,
                              width: _pixelIntegral(newValue),
                              height: self.hheight)
    }
    get { return self.frame.size.width }
  }
  
  /// Height of view.
  public var hheight: CGFloat {
    set { self.frame = CGRect(x: self.xx,
                              y: self.yy,
                              width: self.wwidth,
                              height: _pixelIntegral(newValue))
    }
    get { return self.frame.size.height }
  }
  
  // MARK: - Origin and Size
  
  /// View's Origin point.
  public var origin: CGPoint {
    set { self.frame = CGRect(x: _pixelIntegral(newValue.x),
                              y: _pixelIntegral(newValue.y),
                              width: self.wwidth,
                              height: self.hheight)
    }
    get { return self.frame.origin }
  }
  
  /// View's size.
  public var size: CGSize {
    set { self.frame = CGRect(x: self.xx,
                              y: self.yy,
                              width: _pixelIntegral(newValue.width),
                              height: _pixelIntegral(newValue.height))
    }
    get { return self.frame.size }
  }
  
  // MARK: - Extra Properties
  
  /// View's right side (x + width).
  public var right: CGFloat {
    set { self.xx = newValue - self.wwidth }
    get { return self.xx + self.wwidth }
  }
  
  /// View's bottom (y + height).
  public var bottom: CGFloat {
    set { self.yy = newValue - self.hheight }
    get { return self.yy + self.hheight }
  }
  
  /// View's top (y).
  public var top: CGFloat {
    set { self.yy = newValue }
    get { return self.yy }
  }
  
  /// View's left side (x).
  public var left: CGFloat {
    set { self.xx = newValue }
    get { return self.xx }
  }
  
  /// View's center X value (center.x).
  public var centerX: CGFloat {
    set { self.center = CGPoint(x: newValue, y: self.centerY) }
    get { return self.center.x }
  }
  
  /// View's center Y value (center.y).
  public var centerY: CGFloat {
    set { self.center = CGPoint(x: self.centerX, y: newValue) }
    get { return self.center.y }
  }
  
  /// Last subview on X Axis.
  public  var lastSubviewOnX: UIView? {
    return self.subviews.reduce(UIView(frame: .zero)) {
      return $1.xx > $0.xx ? $1 : $0
    }
  }
  
  /// Last subview on Y Axis.
  public var lastSubviewOnY: UIView? {
    return self.subviews.reduce(UIView(frame: .zero)) {
      return $1.yy > $0.yy ? $1 : $0
    }
  }
  
  // MARK: - Bounds Methods
  
  /// X value of bounds (bounds.origin.x).
  public var boundsX: CGFloat {
    set { self.bounds = CGRect(x: _pixelIntegral(newValue),
                               y: self.boundsY,
                               width: self.boundsWidth,
                               height: self.boundsHeight)
    }
    get { return self.bounds.origin.x }
  }
  
  /// Y value of bounds (bounds.origin.y).
  public var boundsY: CGFloat {
    set { self.frame = CGRect(x: self.boundsX,
                              y: _pixelIntegral(newValue),
                              width: self.boundsWidth,
                              height: self.boundsHeight)
    }
    get { return self.bounds.origin.y }
  }
  
  /// Width of bounds (bounds.size.width).
  public  var boundsWidth: CGFloat {
    set { self.frame = CGRect(x: self.boundsX,
                              y: self.boundsY,
                              width: _pixelIntegral(newValue),
                              height: self.boundsHeight)
    }
    get { return self.bounds.size.width }
  }
  
  /// Height of bounds (bounds.size.height).
  public  var boundsHeight: CGFloat {
    set { self.frame = CGRect(x: self.boundsX,
                              y: self.boundsY,
                              width: self.boundsWidth,
                              height: _pixelIntegral(newValue))
    }
    get { return self.bounds.size.height }
  }
  
  // MARK: - Private Methods
  fileprivate  func _pixelIntegral(_ pointValue: CGFloat) -> CGFloat {
    let scale = UIScreen.main.scale
    return (round(pointValue * scale) / scale)
  }
}

