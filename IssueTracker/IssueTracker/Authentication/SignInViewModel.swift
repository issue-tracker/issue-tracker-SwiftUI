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
    didSet { idValidation() }
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
  private func idValidation() {
    guard 4...12 ~= idText.count else {
      idMessage = "입력값이 부족하거나 많습니다."
      idStatus = .error
      idTimer = nil
      return
    }
    
    if idTimer != nil {
      idTimer = nil
    }
    
    requestIdExists()
    idTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
      self.idTimer = nil
    }
  }
  
  private func requestIdExists() {
    let urlPath = ["signin-id", idText, "exists"]
    
    requestModel?
      .request(pathArray: urlPath) { result, _ in
        DispatchQueue.main.async {
          self.idTimer = nil
          switch result {
          case .success(let data):
            let result = self.validationModel
              .validateCommonInput(data: data)
            self.idMessage = result.message
            self.idStatus = result.result ? .fine : .error
          case .failure(_):
            self.idStatus = .error
            self.idMessage = "Request Failed..."
          }
        }
      }
  }
  // MARK: - [END] id Validation
  
  // MARK: - [START] PW Validation
  private func pwValidation() {
    let result = validationModel
      .validationPW(pwText, message: &pwMessage)
    pwStatus = result ? .fine : .error
    pwMessage = result ? "이상이 발견되지 않았습니다." : "입력값이 부족하거나 많습니다."
  }
  
  private func pwConfirmedValidation() {
    let result = (pwText == pwConfirmText)
    pwConfirmedStatus = result ? .fine : .error
    pwConfirmedMessage = result ? "이상이 발견되지 않았습니다." : "동일한 비밀번호를 입력해주시기 바랍니다."
  }
  // MARK: - [END] PW Validation
  
  // MARK: - [START] Email Validation
  private func emailValidation() {
    guard emailText.isValidEmail() else {
      emailMessage = "정확한 형식의 이메일을 입력해주시기 바랍니다."
      emailStatus = .error
      emailTimer = nil
      return
    }
    
    if emailTimer != nil {
      emailTimer = nil
    }
    
    requestEmailExists()
    emailTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
      self.emailTimer = nil
    }
  }
  
  private func requestEmailExists() {
    let urlPath = ["email", emailText, "exists"]
    
    requestModel?
      .request(pathArray: urlPath) { result, _ in
        self.emailTimer = nil
        DispatchQueue.main.async {
          switch result {
          case .success(let data):
            let result = self.validationModel
              .validateCommonInput(data: data)
            self.emailMessage = result.message
            self.emailStatus = result.result ? .fine : .error
          case .failure(_):
            self.emailStatus = .error
            self.emailMessage = "Request Failed..."
          }
        }
      }
  }
  // MARK: - [END] Email Validation
  
  // MARK: - [START] Nickname Validation
  private func nicknameValidation() {
    guard 2...12 ~= nicknameText.count else {
      nicknameMessage = "입력값이 부족하거나 많습니다."
      nicknameStatus = .error
      nicknameTimer = nil
      return
    }
    
    if nicknameTimer != nil {
      nicknameTimer = nil
    }
    
    requestNicknameExists()
    nicknameTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
      self.nicknameTimer = nil
    }
  }
  
  private func requestNicknameExists() {
    let urlPath = ["nickname", nicknameText, "exists"]
    
    requestModel?
      .request(pathArray: urlPath) { result, response in
        DispatchQueue.main.async {
          self.nicknameTimer = nil
          switch result {
          case .success(let data):
            let result = self.validationModel
              .validateCommonInput(data: data)
            self.nicknameMessage = result.message
            self.nicknameStatus = result.result ? .fine : .error
          case .failure(_):
            self.nicknameStatus = .error
            self.nicknameMessage = "Request Failed..."
          }
        }
      }
  }
  // MARK: - [END] Nickname Validation
  
  // MARK: - [START] Register User. SignIn
  func registerUser() {
    guard isFineFields else {
      alertType = .notEnough
      showAlert = true
      return
    }
    
    guard let requestModel else { return }
    
    requestModel.builder.setBody([
      "signInId": idText,
      "password": pwText,
      "email": emailText,
      "nickname": nicknameText,
      "profileImage": ""
    ])
    requestModel.builder.setHTTPMethod("post")
    requestModel.request(pathArray: ["members", "new", "general"]) { result, response in
      DispatchQueue.main.async {
        switch result {
        case .success(let data):
          
          var result = false
          if
            let res = HTTPResponseModel().getDecoded(from: data, as: PostResponse.self),
            200...299 ~= res.status
          {
            result = true
          }
          
          self.alertType = result ? .confirm : .logic
        case .failure(_):
          self.alertType = .logic
        }
        
        self.showAlert = true
      }
    }
  }
  
  var isFineFields: Bool {
    return idStatus == .fine && pwStatus == .fine && pwConfirmedStatus == .fine && emailStatus == .fine && nicknameStatus == .fine
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

struct SignInResponse: Decodable {
  var id: Int
  var email: String
  var nickname: String
  var profileImage: String
}

struct PostResponse: Decodable {
  let timestamp: String
  let status: Int
  let error: String
  let path: String
}
