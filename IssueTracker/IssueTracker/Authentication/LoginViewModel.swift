//
//  LoginViewModel.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/28.
//

import Foundation

enum LoginRequestError: Error {
  case failedRequest, unExpectedData, unRecognizedResponse
  case processFailed(String), errorWithMessage(String), errorWithCode(String)
  
  func getErrorMessage() -> String? {
    switch self {
    case .processFailed(let msg), .errorWithMessage(let msg), .errorWithCode(let msg):
      return msg
    default:
      return nil
    }
  }
}

class LoginViewModel: ObservableObject {
  // MARK: - [START] States
  var isLoginConfirmed: Bool = false
  
  @Published
  var idTextValue: String = ""
  @Published
  var passwordTextValue: String = ""
  
  @Published
  var showAlert: Bool = false
  var alertTitle: String = ""
  var alertMessage: String = ""
  
  @Published
  var accessToken: String?
  
  enum AlertType {
    case requestLogin, checkLogin, refreshAcessToken
    
    func getTitle() -> String {
      return "작업 결과"
    }
  }
  
  // MARK: - [END] States
  
  // MARK: - [START] Models
  private let requestModel: LoginRequestModel = .init()
  // MARK: - [END] States
  
  // MARK: - [START] Alerts
  private func updateAlertState(type: AlertType, _ error: LoginRequestError) {
    
    alertMessage = error.getErrorMessage() ?? requestModel.defaultErrorMessage
    alertTitle = type.getTitle()
    
    DispatchQueue.main.async {
      self.showAlert = true
    }
  }
  // MARK: - [END] Alerts
  
  func requestLogin(completionHandler: @escaping (Bool) -> Void) {
    
    requestModel.requestLogin(idTextValue, passwordTextValue) { result in
      
      switch result {
      case .success(let loginResponse):
        
        self.isLoginConfirmed = true
        loginResponse.setUserDefaults()
        
      case .failure(let failure):
        self.updateAlertState(type: .requestLogin, failure)
      }
      
      completionHandler(self.isLoginConfirmed)
    }
  }
  
  func checkAlreadyLogin(completionHandler: @escaping (Bool) -> Void) {
    
    requestModel.checkAlreadyLogin { result in
      
      switch result {
      case .success(_):
        self.isLoginConfirmed = true
      case .failure(let failure):
        self.updateAlertState(type: .checkLogin, failure)
      }
      
      completionHandler(self.isLoginConfirmed)
    }
  }
  
  func refreshAccessToken() {
    
    requestModel.refreshAccessToken { result in
      
      switch result {
      case .success(let loginResponse):
        self.accessToken = loginResponse.accessToken.token
      case .failure(let failure):
        self.updateAlertState(type: .refreshAcessToken, failure)
      }
    }
  }
}
