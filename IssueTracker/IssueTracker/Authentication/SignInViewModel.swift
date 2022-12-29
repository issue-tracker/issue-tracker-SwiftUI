//
//  SignInViewModel.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/26.
//

import SwiftUI

class SignInViewModel: ObservableObject {
  // MARK: - [START] States
  @Published var idMessage: String = ""
  @Published var idStatus: InputStatus = .error
  @Published var idTimer: Timer?
  @Published var idText: String = "" {
    didSet { IDValidation() }
  }
  
  @Published var pwMessage: String = ""
  @Published var pwStatus: InputStatus = .error
  @Published var pwText: String = "" {
    didSet { pwValidation() }
  }
  
  @Published var pwConfirmedMessage: String = ""
  @Published var pwConfirmedStatus: InputStatus = .error
  @Published var pwConfirmText: String = "" {
    didSet { pwConfirmedValidation() }
  }
  
  @Published var emailMessage: String = ""
  @Published var emailStatus: InputStatus = .error
  @Published var emailTimer: Timer?
  @Published var emailText: String = "" {
    didSet { emailValidation() }
  }
  
  @Published var nicknameMessage: String = ""
  @Published var nicknameStatus: InputStatus = .error
  @Published var nicknameTimer: Timer?
  @Published var nicknameText: String = "" {
    didSet { nicknameValidation() }
  }
  
  @Published var alertType: AlertType = .confirm
  @Published var showAlert: Bool = false
  
  private(set) var alertMessage = ""
  // MARK: - [END] States
  
  // MARK: - [START] Models
  let requestModel = HTTPRequestModel(URL.membersApiURL)
  let validationModel = SignInValidationModel()
  // MARK: - [END] Models
  
  // MARK: - [START] id Validation
  private func IDValidation() {
    
    idTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
      self.idTimer = nil
    }
    
    if 4...12 ~= idText.count {
      
      requestIDExists()
      
    } else {
      
      idMessage = "입력값이 부족하거나 많습니다."
      idStatus = .error
      idTimer = nil
    }
  }
  
  private func requestIDExists() {
    let urlPath = ["signin-id", idText, "exists"]
    
    requestModel?.request(pathArray: urlPath) { result, _ in
      
      DispatchQueue.main.async {
        
        self.idTimer = nil
        self.updateIDState(result)
      }
    }
  }
  
  private func updateIDState(_ result: Result<Data, Error>) {
    guard let data = try? result.get() else {
      
      idMessage = "Request Failed..."
      idStatus = .error
      return
    }
    
    let validationResult = validationModel.validateCommonInput(data: data)
    idMessage = validationResult.message
    idStatus = validationResult.result ? .fine : .error
  }
  // MARK: - [END] id Validation
  
  // MARK: - [START] PW Validation
  private func pwValidation() {
    let result = validationModel.validationPW(pwText)
    
    pwStatus = result.result ? .fine : .error
    pwMessage = result.message
  }
  
  private func pwConfirmedValidation() {
    let result = (pwText == pwConfirmText)
    
    pwConfirmedStatus = result ? .fine : .error
    pwConfirmedMessage = result ? "이상이 발견되지 않았습니다." : "동일한 비밀번호를 입력해주시기 바랍니다."
  }
  // MARK: - [END] PW Validation
  
  // MARK: - [START] Email Validation
  private func emailValidation() {
    
    emailTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
      self.emailTimer = nil
    }
    
    if emailText.isValidEmail() {
      
      requestEmailExists()
      
    } else {
      
      emailMessage = "정확한 형식의 이메일을 입력해주시기 바랍니다."
      emailStatus = .error
    }
  }
  
  private func requestEmailExists() {
    let urlPath = ["email", emailText, "exists"]
    
    requestModel?.request(pathArray: urlPath) { result, _ in
      
      DispatchQueue.main.async {
        
        self.emailTimer = nil
        self.updateEmailStatus(result)
      }
    }
  }
  
  private func updateEmailStatus(_ result: Result<Data, Error>) {
    guard let data = try? result.get() else {
      
      emailMessage = "Request Failed..."
      emailStatus = .error
      
      return
    }
    
    let validationResult = validationModel.validateCommonInput(data: data)
    emailMessage = validationResult.message
    emailStatus = validationResult.result ? .fine : .error
  }
  // MARK: - [END] Email Validation
  
  // MARK: - [START] Nickname Validation
  private func nicknameValidation() {
    
    nicknameTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
      self.nicknameTimer = nil
    }
    
    if 2...12 ~= nicknameText.count {
      
      requestNicknameExists()
      
    } else {
      
      nicknameMessage = "입력값이 부족하거나 많습니다."
      nicknameStatus = .error
      nicknameTimer = nil
    }
  }
  
  private func requestNicknameExists() {
    let urlPath = ["nickname", nicknameText, "exists"]
    
    requestModel?.request(pathArray: urlPath) { result, response in
      
      DispatchQueue.main.async {
        
        self.nicknameTimer = nil
        self.updateNicknameStatus(result)
      }
    }
  }
  
  private func updateNicknameStatus(_ result: Result<Data, Error>) {
    guard let data = try? result.get() else {
      
      nicknameMessage = "Request Failed..."
      nicknameStatus = .error
      
      return
    }
    
    let validationResult = validationModel.validateCommonInput(data: data)
    nicknameMessage = validationResult.message
    nicknameStatus = validationResult.result ? .fine : .error
  }
  // MARK: - [END] Nickname Validation
  
  // MARK: - [START] Register User. SignIn
  func registerUser() {
    guard isFineFields else {
      
      alertType = .notEnough
      showAlert = true
      
      return
    }
    
    requestModel?.builder
      .setBody(signInRequestBody)
    requestModel?.builder
      .setHTTPMethod("post")
    requestModel?.request(pathArray: ["new", "general"]) { result, response in
      
      DispatchQueue.main.async {
        
        if let data = try? result.get() {
          let errorResponse = HTTPResponseModel().getErrorCodeAndMessageResponse(from: data)
          
          if let message = errorResponse.getErrorMessage() {
            self.alertType = .logic
            self.alertMessage = message
          } else {
            self.alertType = .confirm
          }
          
        } else {
          
          self.alertType = .logic
        }
        
        self.showAlert = true
      }
    }
  }
  
  var isFineFields: Bool {
    [idStatus, pwStatus, pwConfirmedStatus, emailStatus, nicknameStatus]
      .reduce(true, {
        $0 && ($1 == .fine)
      })
  }
  
  var signInRequestBody: [String: String] {
    [
      "signInId": idText,
      "password": pwText,
      "email": emailText,
      "nickname": nicknameText,
      "profileImage": ""
    ]
  }
  
  // MARK: - Enums
  enum AlertType {
    case confirm, logic, notEnough
    
    func getTitle() -> String {
      return self == .confirm ? "완료" : "경고"
    }
    
    func getMessage() -> String {
      switch self {
      case .confirm: return "회원가입이 완료되었습니다."
      case .logic: return "일시적인 오류가 발생하였습니다."
      case .notEnough: return "입력값들을 다시 확인해주시기 바랍니다."
      }
    }
  }
  
  enum InputStatus {
    case error, warning, fine
    
    func getColor() -> Color {
      switch self {
      case .error: return Color.red
      case .warning: return Color.yellow
      case .fine: return Color.green
      }
    }
  }
}

struct PostResponse: Decodable {
  let timestamp: String
  let status: Int
  let error: String
  let path: String
}
