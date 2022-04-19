//
//  ViewController.swift
//  ButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 05.04.2022.
//

import UIKit

private let buttonLayerExamplTag = 77

class ViewController: UIViewController {
  
  @IBOutlet var buttonLayerExampleView: ButtonLayerExampleView?
  
  var backController: Int = -1
  lazy var doSomethingOnce: () -> Void = {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
      ButtonLayerExampleView.exmpStart = true
      self.createButtonLayerExampleView(enable: true)
    }
    return {}
  }()
  
  lazy var startPushTableList: () -> Void = {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
      self.buttonTableListScreenButtonAction(.init())
    }
    return {}
  }()
  
  //MARK: - viewDidAppear
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    _ = startPushTableList
    
    self.backController = backController + 1
    if backController > 0 {
        _ = self.doSomethingOnce
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createButtonLayerExampleView(enable: false)
    
    title = ""
  }
  
  //MARK: - Create ButtonLayerExample
  
  func createButtonLayerExampleView(enable: Bool = true, defaultIndex: Int = 0) {
    
    if !enable {
      self.removeButtonLayerExampleView()
      ButtonLayerExampleView.exmpStart = enable
    }
    
    var next = defaultIndex
    if let current = self.buttonLayerExampleView?.animationType {
      
      
      
      next = current + 1
      if next == (ButtonClick.Style.allCases.count) {
        next = 0
      }
    }
    
    self.removeButtonLayerExampleView()
    
    let exampleView = ButtonLayerExampleView()
    exampleView.tag = buttonLayerExamplTag
    exampleView.animationDuration = 0.45 // 0.3 // 0.45
    exampleView.animationDelay = 0.3 // 0.0 // 0.6 // 1.0
    exampleView.animationType = next
    exampleView.update()
    exampleView.frame = .init(x: 0, y: 60, width:  UIScreen.main.bounds.size.width, height: 223)
    
    exampleView.endAnimationCallback = { [weak self] in
      self?.createButtonLayerExampleView()
    }

    exampleView.startStopUpdate()
    self.buttonLayerExampleView = exampleView
    self.view.addSubview(exampleView)
    
  }
  
  func removeButtonLayerExampleView() {
    
    if let find = self.view.viewWithTag(buttonLayerExamplTag) {
      find.subviews.forEach { v1 in
        v1.removeFromSuperview()
      }
      find.removeFromSuperview()
    }
    self.view.subviews.forEach { v in
      if v.tag == buttonLayerExamplTag {
        v.removeFromSuperview()
      }
    }
    self.buttonLayerExampleView?.removeFromSuperview()
    self.buttonLayerExampleView = nil
  }
  
  
  
  @IBAction func exampleButtonsScreenButtonAction(_ sender: UIButton) {
    buttonLayerExampleView?.startStopAction(false)
    navigationController?.pushViewController(ExampleButtonsViewController.instantiate(), animated: true)
  }
  
  @IBAction func exampleAnimationsScreenButtonAction(_ sender: UIButton) {
    buttonLayerExampleView?.startStopAction(false)
    navigationController?.pushViewController(ExampleAnimationsViewController.instantiate(), animated: true)
  }
  
  @IBAction func buttonTableListScreenButtonAction(_ sender: UIButton) {
    buttonLayerExampleView?.startStopAction(false)
    navigationController?.pushViewController(ButtonTableListViewController.instantiate(), animated: true)
  }
  
  @IBAction func buttonListScreenButtonAction(_ sender: UIButton) {
    buttonLayerExampleView?.startStopAction(false)
    navigationController?.pushViewController(ButtonListViewController.instantiate(), animated: true)
  }
  
  @IBAction func buttonProgramScreenButtonAction(_ sender: UIButton) {
    buttonLayerExampleView?.startStopAction(false)
    navigationController?.pushViewController(ButtonProgramViewController.instantiate(), animated: true)
  }
  
  
  @IBAction func testScreenButtonAction(_ sender: UIButton) {
    buttonLayerExampleView?.startStopAction(false)
    navigationController?.pushViewController(TestViewController.instantiate(), animated: true)
  }
  
  @IBAction func testDoubleScreenButtonAction(_ sender: UIButton) {
    buttonLayerExampleView?.startStopAction(false)
    navigationController?.pushViewController(Test2ViewController.instantiate(), animated: true)
  }
  
  @IBAction func testDemoScreenButtonAction(_ sender: UIButton) {
    buttonLayerExampleView?.startStopAction(false)
    navigationController?.pushViewController(TestDemoViewController.instantiate(), animated: true)
  }
}

