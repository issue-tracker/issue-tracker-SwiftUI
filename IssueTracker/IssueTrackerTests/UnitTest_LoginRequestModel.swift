//
//  UnitTest_LoginRequestModel.swift
//  IssueTrackerTests
//
//  Created by 백상휘 on 2022/12/29.
//

import XCTest

final class UnitTest_LoginRequestModel: XCTestCase {
  let model = LoginRequestModel()
  let viewModel = LoginViewModel()
  
  func test_login() throws {
    let expectation = XCTestExpectation()
    model.requestLogin("testios", "12341234") { result in
      
      switch result {
      case .success(_):
        expectation.fulfill()
      case .failure(let error):
        XCTFail("Login Failed \(error)")
      }
    }
    
    wait(for: [expectation], timeout: 3.0)
  }
  
  func test_checkAlreadyLogin() throws {
    let expectation = XCTestExpectation()
    
    model.checkAlreadyLogin { result in
      
      switch result {
      case .success(_):
        expectation.fulfill()
      case .failure(let error):
        XCTFail("Check alreadyLogin Failed \(error)")
      }
    }
    
    wait(for: [expectation], timeout: 3.0)
  }
  
  func test_refreshAcessToken() throws {
    let expectation = XCTestExpectation()
    
    model.refreshAccessToken { result in
      
      switch result {
      case .success(_):
        expectation.fulfill()
      case .failure(let error):
        XCTFail("Refresh Access Token Failed \(error)")
      }
    }
    
    wait(for: [expectation], timeout: 3.0)
  }
}
