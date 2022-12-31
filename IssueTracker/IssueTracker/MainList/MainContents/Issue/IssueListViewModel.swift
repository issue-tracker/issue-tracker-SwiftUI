//
//  IssueListViewModel.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/31.
//

import Foundation

class IssueListViewModel {
  
  @Published
  private(set) var issueLists: [IssueListEntity] = []
  
  @Published
  var showAlert: Bool = false
  private(set) var alertTitle: String = ""
  private(set) var alertMessage: String = ""
  
  @Published
  var showToast: Bool = false
  var toastColor: RGBColorValues = .gray
  var toastMessage: String = ""
  
  private let opacityValue: Double = 0.3
  
  let requestModel = HTTPRequestModel(URL.issueApiURL)
  
  func getIssueList(pageNumber: Int = 0, completionHandler: @escaping ([IssueListEntity])->Void) {
    guard let requestModel else { return }
    
    requestModel.builder.setURLQuery(["page": "\(pageNumber)"])
    requestModel.request { result, response in
      
      guard
        let data = try? result.get(),
        let result = HTTPResponseModel().getDecoded(from: data, as: AllIssueEntity.self)
      else {
        return
      }
      
      self.issueLists = result.issues
    }
  }
}

