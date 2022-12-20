//
//  UserStateModel.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/20.
//

import Foundation
import SwiftUI

class UserStateModel {
  let userState: Binding<UserState>
  
  init(userState: Binding<UserState>) {
    self.userState = userState
  }
}
