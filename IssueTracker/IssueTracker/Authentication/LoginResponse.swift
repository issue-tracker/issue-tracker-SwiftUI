//
//  LoginResponse.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/29.
//

import Foundation

struct LoginResponse: Decodable {
  var memberResponse: MemberResponse
  var accessToken: AccessToken
  var refreshToken: String?
  var errorMessage: String?
  var errorCode: Int?
}

extension LoginResponse {
  func setUserDefaults() {
    UserDefaults.standard.setValue(self.accessToken.token, forKey: "accessToken")
    UserDefaults.standard.setValue(self.memberResponse.profileImage, forKey: "profileImage")
    UserDefaults.standard.setValue(self.memberResponse.id, forKey: "memberId")
  }
  
  static func removeUserDefaults() {
    UserDefaults.standard.removeObject(forKey: "accessToken")
    UserDefaults.standard.removeObject(forKey: "profileImage")
    UserDefaults.standard.removeObject(forKey: "memberId")
  }
}

struct MemberResponse: Decodable {
  var id: Int
  var email: String
  var nickname: String
  var profileImage: String
}

struct AccessToken: Decodable {
  var token: String
  var errorType: String?
}
