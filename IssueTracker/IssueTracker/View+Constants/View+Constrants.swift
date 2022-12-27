//
//  View+Constrants.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/19.
//

import SwiftUI

extension View {
  var spacing: CGFloat { 16 }
  
  var commonInputFieldBackground: Color {
    Color.blue.opacity(0.2)
  }
  
  var commonTouchFieldBackground: Color {
    Color.blue.opacity(0.8)
  }
  
  var commonInputFieldRoundedShape: RoundedRectangle {
    RoundedRectangle(cornerRadius: spacing)
  }
}
