//
//  Localizable+Extensions.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/19.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
