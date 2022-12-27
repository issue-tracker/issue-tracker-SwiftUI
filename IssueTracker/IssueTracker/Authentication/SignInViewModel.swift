//
//  SignInViewModel.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/26.
//

import SwiftUI

class SignInViewModel: ObservableObject {
  
  @Published
  var idText: String = "" {
    didSet { idValidation() }
  }
  @Published
  var idMessage: String = ""
  var isFineId: Bool = false
  
  @Published
  var pwText: String = "" {
    didSet { pwValidation() }
  }
  @Published
  var pwMessage: String = ""
  var isFinePW: Bool = false
  
  @Published
  var pwConfirmText: String = "" {
    didSet { pwConfirmedValidation() }
  }
  @Published
  var pwConfirmedMessage: String = ""
  var isFinePwConfirmed: Bool = false
  
  @Published
  var emailText: String = "" {
    didSet { emailValidation() }
  }
  @Published
  var emailMessage: String = ""
  var isFineEmail: Bool = false
  
  @Published
  var nicknameText: String = "" {
    didSet { nicknameValidation() }
  }
  @Published
  var nicknameMessage: String = ""
  var isFineNickname: Bool = false
  
  var isFineFields: Bool {
    return isFineId
    && isFinePW
    && isFinePwConfirmed
    && isFineEmail
    && isFineNickname
  }
  
  enum AlertType {
    case confirm, logic, notEnough
    
    func getTitle() -> String {
      switch self {
      case .confirm:
        return "완료"
      default:
        return "경고"
      }
    }
    
    func getMessage() -> String {
      switch self {
      case .confirm:
        return "회원가입이 완료되었습니다."
      case .logic:
        return "일시적인 오류가 발생하였습니다."
      case .notEnough:
        return "입력값들을 다시 확인해주시기 바랍니다."
      }
    }
  }
  
  @Published
  var alertType: AlertType = .confirm
  
  @Published
  var showAlert: Bool = false
  private(set) var alertMessage = ""
  
  let requestModel = HTTPRequestModel(URL.membersApiURL)
  let validationModel = SignInValidationModel()
  
  private func idValidation() {
    guard 4...12 ~= idText.count else {
      isFineId = false
      idMessage = "입력값이 부족하거나 많습니다."
      return
    }
    
    requestModel?
      .request(pathArray: ["signin-id", idText, "exists"]) { result, response in
        DispatchQueue.main.async {
          switch result {
          case .success(let data):
            let result = self.validationModel
              .validateCommonInput(data: data)
            self.isFineId = result.result
            self.idMessage = result.message
          case .failure(_):
            self.isFineId = false
            self.idMessage = "Request Failed..."
          }
        }
      }
  }
  
  private func pwValidation() {
    isFinePW = self.validationModel
      .validationPW(pwText, message: &pwMessage)
    pwMessage = isFinePW ? "이상이 발견되지 않았습니다." : "입력값이 부족하거나 많습니다."
  }
  
  private func pwConfirmedValidation() {
    isFinePwConfirmed = (pwText == pwConfirmText)
    pwConfirmedMessage = isFinePwConfirmed ? "이상이 발견되지 않았습니다." : "동일한 비밀번호를 입력해주시기 바랍니다."
  }
  
  private func emailValidation() {
    requestModel?
      .request(pathArray: ["email", emailText, "exists"]) { result, response in
        DispatchQueue.main.async {
          switch result {
          case .success(let data):
            let result = self.validationModel
              .validateCommonInput(data: data)
            self.isFineEmail = result.result
            self.emailMessage = result.message
          case .failure(_):
            self.isFineEmail = false
            self.emailMessage = "Request Failed..."
          }
        }
      }
  }
  
  private func nicknameValidation() {
    guard 2...12 ~= nicknameText.count else {
      isFineNickname = false
      idMessage = "입력값이 부족하거나 많습니다."
      return
    }
    
    requestModel?
      .request(pathArray: ["nickname", nicknameText, "exists"]) { result, response in
        DispatchQueue.main.async {
          switch result {
          case .success(let data):
            let result = self.validationModel
              .validateCommonInput(data: data)
            self.isFineNickname = result.result
            self.nicknameMessage = result.message
          case .failure(_):
            self.isFineNickname = false
            self.nicknameMessage = "Request Failed..."
          }
        }
      }
  }
  
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
