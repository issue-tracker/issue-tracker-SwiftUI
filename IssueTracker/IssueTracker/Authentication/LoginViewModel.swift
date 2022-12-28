//
//  LoginViewModel.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/28.
//

import Foundation

class LoginViewModel: ObservableObject {
  @Published
  var idTextValue: String = ""
  @Published
  var passwordTextValue: String = ""
  
  @Published
  var showAlert: Bool = false
  var alertMessage: String = ""
}
