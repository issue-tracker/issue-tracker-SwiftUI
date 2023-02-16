//
//  InputField.swift
//  IssueTracker
//
//  Created by 백상휘 on 2023/02/16.
//

import SwiftUI

struct InputField: View {
  let labels: [DescriptionText]
  let textField: CommonTextField
  
  @State var isFineText = false
  
  init(
    labels: [DescriptionText],
    textField: CommonTextField
  ) {
    self.labels = labels
    self.textField = textField
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      ForEach(labels) { label in
        label
      }
      
      textField
    }
    .padding(.trailing, 16)
  }
}

struct InputField_Previews: PreviewProvider {
  static var previews: some View {
    InputField(labels: [
      DescriptionText(text: "Test", isBold: true),
      DescriptionText(text: "Test", isBold: true)
    ], textField: CommonTextField(
      placeHolder: I18N.L_N_SIVC_TXTF_EMAIL,
      text: .constant("test@gmail.com")
    )
    )
  }
}
