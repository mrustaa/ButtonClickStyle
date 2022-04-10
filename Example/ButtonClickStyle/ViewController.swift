//
//  ViewController.swift
//  ButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 05.04.2022.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
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

