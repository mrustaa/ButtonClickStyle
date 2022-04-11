//
//  ViewController.swift
//  ButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 05.04.2022.
//

import UIKit

class ViewController: UIViewController {
  
    lazy var doSomethingOnce: () -> Void = {
      buttonListScreenButtonAction(.init())
      return {}
    }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
        _ = doSomethingOnce
    // Do any additional setup after loading the view.
  }
  
  @IBAction func exampleButtonsScreenButtonAction(_ sender: UIButton) {
    navigationController?.pushViewController(ExampleButtonsViewController.instantiate(), animated: true)
  }
  
  
  @IBAction func exampleAnimationsScreenButtonAction(_ sender: UIButton) {
    navigationController?.pushViewController(ExampleAnimationsViewController.instantiate(), animated: true)
  }
  
  @IBAction func buttonListScreenButtonAction(_ sender: UIButton) {
    navigationController?.pushViewController(ButtonListViewController.instantiate(), animated: true)
  }
  
  @IBAction func testScreenButtonAction(_ sender: UIButton) {
    navigationController?.pushViewController(TestViewController.instantiate(), animated: true)
  }
  
  @IBAction func testDemoScreenButtonAction(_ sender: UIButton) {
    navigationController?.pushViewController(TestDemoViewController.instantiate(), animated: true)
  }
}

