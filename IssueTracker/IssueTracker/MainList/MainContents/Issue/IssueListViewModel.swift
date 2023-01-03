//
//  IssueListViewModel.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/31.
//

import Foundation

enum MainContentsGridRowNumber: Int {
  case one = 1
  case two = 2
  case three = 3
}

class IssueListViewModel: ObservableObject {
  
  @Published
  var issueLists: [IssueListEntity] = []
  
  @Published
  var gridRowNumber: MainContentsGridRowNumber = .two
  
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
  
  init() {
    getIssueList()
  }
  
  func getIssueList(pageNumber: Int = 0) {
    guard let requestModel else { return }
    
    requestModel.builder.setURLQuery(["page": "\(pageNumber)"])
    requestModel.request { result, response in
      
      guard let data = try? result.get() else { return }
      print(String(data: data, encoding: .utf8) ?? "")
      let result = HTTPResponseModel().getDecoded(from: data, as: AllIssueEntity.self)?.issues ?? []
      
      DispatchQueue.main.async {
        self.issueLists = result
      }
    }
  }
}
