//
//  SignInValidationModel.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/27.
//

import SwiftUI

class SignInValidationModel {
  
  private let responseModel = HTTPResponseModel()
  
  func validationPW(_ text: String) -> ValidationResult {
    let result = text.count >= 8
    let message = result ? "이상이 발견되지 않았습니다." : "입력값을 다시 확인해주시기 바랍니다."
    return ValidationResult(result: result, message: message)
  }
  
  func validateCommonInput(data: Data) -> ValidationResult {
    guard let result = HTTPResponseModel().getDecoded(from: data, as: Bool.self) else {
      return ValidationResult(result: false, message: "재시도 바랍니다.")
    }
    
    if let responseMessage = HTTPResponseModel().getMessageResponse(from: data) {
      return ValidationResult(result: false, message: responseMessage)
    }
    
    return ValidationResult(
      result: !result,
      message: !result ? "이상이 발견되지 않았습니다." : "중복된 아이디 입니다."
    )
  }
  
  struct ValidationResult {
    let result: Bool
    let message: String
  }
}
