import UIKit

// MARK: - Item

class MainCollectionItem: TableAdapterItem {
  
  init(cellHeight: CGFloat,
       items: [CollectionAdapterItem],
       scrollDirection: UICollectionView.ScrollDirection = .horizontal,
       isScrollEnabled: Bool = true,
       minSpacingCell: CGFloat = 0,
       minSpacingLines: CGFloat = 0,
       sectionInsets: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0),
       clickCallback: (() -> ())? = nil) {
    
    let cellData = MainCollectionCellData(cellHeight: cellHeight,
                                          items: items,
                                          scrollDirection: scrollDirection,
                                          isScrollEnabled: isScrollEnabled,
                                          minSpacingCell: minSpacingCell,
                                          minSpacingLines: minSpacingLines,
                                          sectionInsets: sectionInsets,
                                          clickCallback: clickCallback)
    
    super.init(cellClass: MainCollectionCell.self, cellData: cellData)
  }
}

// MARK: - Data

class MainCollectionCellData: TableAdapterCellData {
  
  // MARK: Properties
  var height: CGFloat
  var items: [CollectionAdapterItem]
  var scrollDirection: UICollectionView.ScrollDirection
  var isScrollEnabled: Bool = true
  var minSpacingCell: CGFloat
  var minSpacingLines: CGFloat
  var sectionInsets: UIEdgeInsets
  
  // MARK: Inits
  
  init(cellHeight: CGFloat,
       items: [CollectionAdapterItem],
       scrollDirection: UICollectionView.ScrollDirection,
       isScrollEnabled: Bool,
       minSpacingCell: CGFloat,
       minSpacingLines: CGFloat,
       sectionInsets: UIEdgeInsets,
       clickCallback: (() -> ())?) {
    
    self.height = cellHeight
    self.items = items
    self.scrollDirection = scrollDirection
    self.isScrollEnabled = isScrollEnabled
    self.minSpacingCell = minSpacingCell
    self.minSpacingLines = minSpacingLines
    self.sectionInsets = sectionInsets
    
    super.init()
    self.cellClickCallback = clickCallback
  }
  
  override public func cellHeight() -> CGFloat {
    return height
  }
  
  override public func canEditing() -> Bool {
    return editing
  }
  
  
  override func equals(compareTo data: TableAdapterCellData) -> Bool {
    guard let to = data as? MainCollectionCellData else { return false }
    return ((self.height == to.height))
  }
}

// MARK: - Cell

class MainCollectionCell: TableAdapterCell {
  
  // MARK: Properties
  
  public var data: MainCollectionCellData?
  
  // MARK: Outlets
  
  @IBOutlet weak var collectionView: CollectionAdapterView!
  
  @IBOutlet override var selectedView: UIView? { didSet { } }
  
  // MARK: Initialize
  
  override func awakeFromNib() {
    separator(hide: true)
  }
  
  override func fill(data: TableAdapterCellData?) {
    guard let data = data as? MainCollectionCellData else { return }
    self.data = data
    
    self.hideAnimation = data.touchAnimationHide
    separator(hide: !data.separatorVisible)
    
    updateCollection()
  }
  
  func updateCollection() {
    guard let data = data else { return }
    
    if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.minimumInteritemSpacing = data.minSpacingCell
      flowLayout.minimumLineSpacing = data.minSpacingLines
      flowLayout.sectionInset = data.sectionInsets
      flowLayout.scrollDirection = data.scrollDirection
    }
    
    self.didScrollCallback = {
      self.didScroll()
    }
    
    collectionView.isScrollEnabled = data.isScrollEnabled
    
    collectionView.set(items: data.items)
    collectionView.didScrollCallback = {
      self.didScroll()
    }
  }
  
  func didScroll() {
    for cell in self.collectionView.visibleCells {
      if let cell = cell as? CollectionAdapterCell {
        cell.didScrollCallback?()
      }
    }
  }
  
}

