//
//  UserState.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/20.
//

import Foundation
import SwiftUI

class UserState: ObservableObject {
  @Published
  var isLogin: Bool = false
  
  @Published
  var userInfo: UserInfo = .init()
}

struct UserInfo: Codable {
  private(set) var id: Int = -1
  private(set) var meail: String = ""
  private(set) var nickname: String = ""
  private(set) var profileImage: String = ""
}
