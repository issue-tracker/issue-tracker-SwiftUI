//
//  LoginViewModel.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/28.
//

import Foundation

enum LoginRequestError: Error {
  case failedRequest, unExpectedData, unRecognizedResponse
  case processFailed(String), errorWithMessage(String), errorWithCode(Int)
}

class LoginViewModel: ObservableObject {
  
  @Published
  var idTextValue: String = ""
  @Published
  var passwordTextValue: String = ""
  @Published
  var isLoginConfirmed: Bool = false
  
  @Published
  var showAlert: Bool = false
  var alertMessage: String = ""
  
  @Published
  var accessToken: String?
  
  private let requestModel: LoginRequestModel = .init()
  
  private var defaultErrorMessage = "알 수 없는 에러가 발생하였습니다. 다시 시도해주시기 바랍니다."
  
  private func showAlert(_ error: LoginRequestError) {
    switch error {
    case .processFailed(let message):
      
      alertMessage = message
      
    case .errorWithMessage(let message):
      
      alertMessage = message
      
    default:
      
      alertMessage = defaultErrorMessage
    }
    
    self.showAlert = true
  }
  
  func requestLogin() {
    
    requestModel.requestLogin(idTextValue, passwordTextValue) { result in
      
      switch result {
      case .success(let loginResponse):
        
        loginResponse.setUserDefaults()
        self.isLoginConfirmed = true
        
      case .failure(let failure):
        
        self.showAlert(failure)
      }
    }
  }
  
  func checkAlreadyLogin() {
    
    requestModel.checkAlreadyLogin { result in
      
      switch result {
      case .success(_):
        
        self.isLoginConfirmed = true
        
      case .failure(let failure):
        
        self.showAlert(failure)
      }
    }
  }
  
  func refreshAccessToken() {
    
    requestModel.refreshAccessToken { result in
      
      switch result {
      case .success(let loginResponse):
        
        self.accessToken = loginResponse
          .accessToken.token
        
      case .failure(let failure):
        
        self.showAlert(failure)
      }
    }
  }
}
