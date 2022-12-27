//
//  CommonButton.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/19.
//

import SwiftUI

struct CommonButton: View {
  
  let buttonTitle: String
  var actionHandler: (()->Void)?
  
  init(buttonTitle: String, actionHandler: (() -> Void)? = nil) {
    self.buttonTitle = buttonTitle
    self.actionHandler = actionHandler
  }
  
  var body: some View {
    Button(action: {
      actionHandler?()
    }) {
      HStack {
        Spacer()
        Text(buttonTitle)
        Spacer()
      }
      .toCommon()
    }
  }
}

struct CommonHorizontalButtonModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding()
      .foregroundColor(Color.white)
      .background(Color.blue.opacity(0.8))
      .clipShape(RoundedRectangle(cornerRadius: content.spacing))
  }
}

extension View {
  func toCommon() -> some View {
    ModifiedContent(content: self, modifier: CommonHorizontalButtonModifier())
  }
}

struct CommonButton_Previews: PreviewProvider {
  static var previews: some View {
    CommonButton(buttonTitle: I18N.L_N_LVC_BTN_LOGIN)
  }
}
