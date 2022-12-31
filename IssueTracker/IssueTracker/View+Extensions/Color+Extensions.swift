//
//  Color+Extensions.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/31.
//

import SwiftUI

extension Color {
  
}

struct RGBColorValues {
  let red: Double
  let green: Double
  let blue: Double
  let opacity: Double = 1
  
  func toColor() -> Color {
    return Color(
      red: red, green: green,
      blue: blue, opacity: opacity
    )
  }
}

extension RGBColorValues {
  static var blue: RGBColorValues {
    RGBColorValues(red: 51/255, green: 51/255, blue: 1)
  }
  
  static var red: RGBColorValues {
    RGBColorValues(red: 255, green: 51/255, blue: 51/255)
  }
  
  static var gray: RGBColorValues {
    RGBColorValues(red: 192/255, green: 192/255, blue: 192/255)
  }
}
