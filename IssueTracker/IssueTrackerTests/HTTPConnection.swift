//
//  HTTPConnection.swift
//  IssueTrackerTests
//
//  Created by 백상휘 on 2022/12/26.
//

import XCTest

final class HTTPConnection: XCTestCase {
  let model = HTTPRequestModel(URL.membersApiURL)
  
  func testURLRequestBuilder() throws {
    guard let model else {
      XCTFail("baseURL Error")
      return
    }
    
    // 1. is url fine
    XCTAssertNotNil(model.builder.baseURL)
    
    // 2. can get getRequest
    XCTAssertNotNil(model.builder.getRequest())
    
    // 3. http methods
    for method in URLRequestBuilder.allHTTPMethods {
      model.builder.setHTTPMethod(method)
      XCTAssertNotNil(model.builder.getRequest())
    }
    
    // 4. set url query
    model.builder.setURLQuery(["test": "testable", "number": "0"])
    XCTAssertNotNil(model.builder.getRequest())
    
    // 5. setting header
    for header in URLRequestBuilder.allHeaderFields {
      model.builder.setHeader(key: header, value: "test")
      XCTAssertNotNil(model.builder.getRequest())
    }
  }
  
  func testHTTPRequestModel() throws {
    guard let model else {
      XCTFail("baseURL Error")
      return
    }
    
    let expectation = XCTestExpectation()
    let testContents = [
      ["signin-id", "blank", "exists"],
      ["email", "whatemail", "exists"],
      ["nickname", "back", "exists"],
    ]
    
    expectation.expectedFulfillmentCount = testContents.count
    for content in testContents {
      model.request(pathArray: content) { result, response in
        switch result {
        case .success(_):
          expectation.fulfill()
        case .failure(let failure):
          XCTFail("requestFailed: error: \(failure), url: \(response?.url?.absoluteString ?? "Unknown")")
        }
      }
    }
    
    wait(for: [expectation], timeout: 5.0)
  }
}
