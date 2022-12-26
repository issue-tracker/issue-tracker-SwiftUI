//
//  SignInView.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/21.
//

import SwiftUI

struct SignInView: View {
  @State var idText: String = ""
  @State var pwText: String = ""
  @State var pwConfirmText: String = ""
  @State var emailText: String = ""
  @State var nicknameText: String = ""
  
  @State var isAlertShow: Bool = false
  
  var body: some View {
    ScrollView {
      VStack(spacing: 15) {
        InputField(
          labels: [
            DescriptionText(text: I18N.L_N_SIVC_LB_ID, isBold: true),
            DescriptionText(text: I18N.L_N_SIVC_LB_ID_DESC)
          ],
          textField: CommonTextField(
            placeHolder: I18N.L_N_SIVC_TXTF_ID,
            text: $idText)
        ) { text -> Bool in
          return 4...12 ~= text.count
        }
        
        InputField(
          labels: [
            DescriptionText(text: I18N.L_N_SIVC_LB_PW, isBold: true),
            DescriptionText(text: I18N.L_N_SIVC_LB_PW_DESC)
          ],
          textField: CommonTextField(
            placeHolder: I18N.L_N_SIVC_TXTF_PW,
            text: $nicknameText)
        ) { text -> Bool in
          return text.count >= 8
        }
        
        InputField(
          labels: [DescriptionText(text: I18N.L_N_SIVC_LB_PW_CONF, isBold: true)],
          textField: CommonTextField(
            placeHolder: I18N.L_N_SIVC_TXTF_PW_CONF,
            text: $pwConfirmText)
        )
        
        InputField(
          labels: [DescriptionText(text: I18N.L_N_SIVC_LB_EMAIL, isBold: true)],
          textField: CommonTextField(
            placeHolder: I18N.L_N_SIVC_TXTF_EMAIL,
            text: $emailText)
        )
        
        InputField(
          labels: [
            DescriptionText(text: I18N.L_N_SIVC_LB_NICK, isBold: true),
            DescriptionText(text: I18N.L_N_SIVC_LB_NICK_DESC)
          ],
          textField: CommonTextField(
            placeHolder: I18N.L_N_SIVC_TXTF_NICK,
            text: $nicknameText)
        ) { text -> Bool in
          return 2...12 ~= text.count
        }
        
        Button(I18N.L_N_SIVC_BTN_CONF) {
          guard !idText.isEmpty && !pwText.isEmpty && !pwConfirmText.isEmpty && !emailText.isEmpty && !nicknameText.isEmpty else {
            return
          }
          
          isAlertShow = true
        }
        .alert(isPresented: $isAlertShow) {
          let dismissButton = Alert.Button.default(Text("OK")) {
            isAlertShow = false
          }
          
          return Alert(
            title: Text("Congratulations!"),
            message: Text("Made in 5 minute."),
            dismissButton: dismissButton
          )
        }
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
      }
    }
#if targetEnvironment(macCatalyst)
    .padding()
#endif
    
  }
  
  struct InputField: View {
    let labels: [DescriptionText]
    let textField: CommonTextField
    let validationHandler: ((String)->Bool)?
    
    @State var isFineText = false
    
    init(labels: [DescriptionText], textField: CommonTextField, _ validationHandler: ((String) -> Bool)? = nil) {
      self.labels = labels
      self.textField = textField
      self.validationHandler = validationHandler
    }
    
    var body: some View {
      VStack(alignment: .leading, spacing: 4) {
        HStack(alignment: .center, spacing: 0) {
          Circle()
            .foregroundColor(isFineText ? .blue : .red)
            .frame(width: 8,height: 8)
            .padding(4)
          if let label = labels.first {
            label
          }
        }
        
        if labels.count >= 2 {
          labels.last!
            .padding(.leading)
        }
        
        textField
          .padding(.horizontal)
          .onChange(of: textField.text) { newValue in
            self.isFineText = validationHandler?(newValue) ?? !newValue.isEmpty
          }
      }
    }
  }
  
  struct DescriptionText: View {
    private let text: String
    private let isBold: Bool
    
    private var customFont: UIFont {
      isBold ? UIFont.boldSystemFont(ofSize: 15) : UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    init(text: String, isBold: Bool = false) {
      self.text = text
      self.isBold = isBold
    }
    
    var body: some View {
      Text(text)
        .font(Font(customFont))
    }
  }
}

struct SignInView_Previews: PreviewProvider {
  static var previews: some View {
    SignInView()
  }
}