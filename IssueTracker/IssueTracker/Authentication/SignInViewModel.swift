//
//  SignInViewModel.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/26.
//

import SwiftUI

class SignInViewModel: ObservableObject {
  
  @Published
  var idText: String = ""
  var isFineId: Bool {
    4...12 ~= idText.count
  }
  
  @Published
  var pwText: String = ""
  var isFinePw: Bool {
    pwText.count >= 8
  }
  
  @Published
  var pwConfirmText: String = ""
  var isFinePwConfirmed: Bool {
    return pwText.isEmpty == false
    && pwConfirmText.isEmpty == false
    && pwText == pwConfirmText
  }
  
  @Published
  var emailText: String = ""
  var isFineEmail: Bool {
    emailText.isEmpty == false
  }
  
  @Published
  var nicknameText: String = ""
  var isFineNickname: Bool {
    2...12 ~= nicknameText.count
  }
  
  var isFineFields: Bool {
    return isFineId
    && isFinePw
    && isFinePwConfirmed
    && isFineEmail
    && isFineNickname
  }
  
  @Published
  var showConfirmedAlert: Bool = false
  
  @Published
  var showNotEnoughAlert: Bool = false
  
  @Published
  var showLogicAlert: Bool = false
  
  let requestModel = HTTPRequestModel(URL.membersApiURL)
}
