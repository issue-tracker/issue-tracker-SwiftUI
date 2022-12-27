//
//  CommonTextField.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/19.
//

import SwiftUI

struct CommonTextField: View {
  
  let capImage: Image?
  let isSecure: Bool
  let placeHolder: String
  
  @Binding var text: String
  
  init(
    capImage: Image? = nil,
    isSecure: Bool = false,
    placeHolder: String,
    text: Binding<String>
  ) {
    self.capImage = capImage
    self.isSecure = isSecure
    self.placeHolder = placeHolder
    self._text = text
  }
  
  var body: some View {
    HStack(spacing: spacing) {
      if let capImage {
        capImage
          .frame(width: 20, height: 20)
      }
      
      if isSecure {
        SecureField(
          placeHolder,
          text: $text)
      } else {
        TextField(placeHolder,
                  text: $text)
        .font(.title3)
      }
      
    }
    .padding()
    .background(commonInputFieldBackground)
    .clipShape(commonInputFieldRoundedShape)
  }
}

struct CommonTextField_Previews: PreviewProvider {
  @State static var value: String = ""
  
  static var previews: some View {
    CommonTextField(
      capImage: Image.personWave2Fill,
      placeHolder: I18N.L_N_LVC_TXTF_ID, text: $value)
  }
}
