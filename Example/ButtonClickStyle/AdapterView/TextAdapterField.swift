//
//  TextAdapterField.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 27.07.2021.
//

import UIKit

open class TextAdapterField: UITextField {
  
  var onFocused = false
  
  // MARK: Callbacks
  
  public var editingBegin: (() -> ())?
  public var editingEnd: (() -> ())?
  public var onReturn: (() -> ())?
  public var changeText: ((String) -> Bool)?
  
  
  // MARK: - Init
  
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    update()
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    update()
  }
  
  public func update() {
    delegate = self
  }
  
  public func uiDisable() {
    isUserInteractionEnabled = false
  }
  
  public func uiEnable() {
    isUserInteractionEnabled = true
  }
  
  public func open() {
    keyboard(visible: true)
  }
  
  public func close() {
    keyboard(visible: false)
  }
  
  public func keyboard(visible: Bool) {
    if visible {
      resignFirstResponder()
    } else {
      becomeFirstResponder()
    }
  }
  
}

extension TextAdapterField: UITextFieldDelegate {
  
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    onFocused = true
    editingBegin?()
  }
  
  public func textFieldDidEndEditing(_ textField: UITextField) {
    onFocused = false
    editingEnd?()
  }
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    onReturn?()
    return true
  }
  
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let newString = (((textField.text ?? .empty)) as NSString).replacingCharacters(in: range,  with: string)
    return changeText?(newString) ?? true
  }
}

//MARK: - Constants
extension String {
  static let empty: String = ""
  static let whitespace: String = " "
  static let slash: String = "/"
  static let newLine: String = "\n"
  static let endLine: String = "\r\n"
  static let colon: String = ":"
  static let semicolon: String = ";"
  static let equal: String = "="
  static let and: String = "&"
}
