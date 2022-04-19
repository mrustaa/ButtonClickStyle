//
//  ButtonClick+StyleShort.swift
//  ButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 10.04.2022.
//

import UIKit

extension ButtonClick {
  
  //MARK: - Style
  
  public enum _Style: Int, CaseIterable {
    case alpha                //  0
    case flash                //  1
    case shadow               //  2
    case shadowColor          //  3
    case color                //  4
    case colorFlat            //  5
    case pulsateNew           //  6
    case pulsate              //  7
    case press                //  8
    case shake                //  9
    case shakeNew             // 10
    case androidClickable     // 11
    case androidClickableDark // 12
    case fave                 // 13
    case glare                // 14
  }
}
