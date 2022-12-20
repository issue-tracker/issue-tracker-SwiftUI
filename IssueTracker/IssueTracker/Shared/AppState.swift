//
//  AppState.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/20.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
  @Published
  var appearance: AppAppearance = .light
}

enum AppAppearance: Int, CaseIterable, Identifiable {
  case light, dark, automatic
  var id: Int { self.rawValue }
  
  var name: String {
    switch self {
    case .light: return "light"
    case .dark: return "dark"
    case .automatic: return "automatic"
    }
  }
}
