//
//  AppStateModel.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/20.
//

import Foundation
import SwiftUI

class AppStateModel {
  private var appearance: Binding<AppAppearance>
  
  init(_ appearance: Binding<AppAppearance>) {
    self.appearance = appearance
  }
}
