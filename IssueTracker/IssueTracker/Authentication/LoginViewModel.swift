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
  // MARK: - [START] States
  @Published
  var idTextValue: String = ""
  @Published
  var passwordTextValue: String = ""
  @Published
  var isLoginConfirmed: Bool = false
  
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
  
  private var defaultErrorMessage = "알 수 없는 에러가 발생하였습니다. 다시 시도해주시기 바랍니다."
  
  // MARK: - [START] Alerts
  private func updateAlertState(type: AlertType, _ error: LoginRequestError) {
    switch error {
    case .processFailed(let msg):
      alertMessage = msg
    case .errorWithMessage(let msg):
      alertMessage = msg
    default:
      alertMessage = defaultErrorMessage
    }
    
    alertTitle = type.getTitle()
    
    DispatchQueue.main.async { [weak self] in
      self?.showAlert = true
    }
  }
  // MARK: - [END] Alerts
  
  func requestLogin(completionHandler: @escaping (Bool) -> Void) {
    
    requestModel.requestLogin(idTextValue, passwordTextValue) { result in
      
      switch result {
      case .success(let loginResponse):
        
        loginResponse.setUserDefaults()
        self.isLoginConfirmed = true
        
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
