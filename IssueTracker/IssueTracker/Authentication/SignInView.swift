//
//  SignInView.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/21.
//

import SwiftUI

struct SignInView: View {
  @ObservedObject var vm = SignInViewModel()
  
  var body: some View {
    ScrollView {
      VStack(spacing: 15) {
        InputField(
          labels: [
            DescriptionText(text: I18N.L_N_SIVC_LB_ID, isBold: true),
            DescriptionText(text: I18N.L_N_SIVC_LB_ID_DESC),
            DescriptionText(text: vm.idMessage),
          ],
          textField: CommonTextField(
            placeHolder: I18N.L_N_SIVC_TXTF_ID,
            text: $vm.idText),
          fieldStatus: vm.isFineId
        )
        
        InputField(
          labels: [
            DescriptionText(text: I18N.L_N_SIVC_LB_PW, isBold: true),
            DescriptionText(text: I18N.L_N_SIVC_LB_PW_DESC),
            DescriptionText(text: vm.pwMessage),
          ],
          textField: CommonTextField(
            placeHolder: I18N.L_N_SIVC_TXTF_PW,
            text: $vm.pwText),
          fieldStatus: vm.isFinePW
        )
        
        InputField(
          labels: [
            DescriptionText(text: I18N.L_N_SIVC_LB_PW_CONF, isBold: true),
            DescriptionText(text: vm.pwConfirmedMessage),
          ],
          textField: CommonTextField(
            placeHolder: I18N.L_N_SIVC_TXTF_PW_CONF,
            text: $vm.pwConfirmText),
          fieldStatus: vm.isFinePwConfirmed
        )
        
        InputField(
          labels: [
            DescriptionText(text: I18N.L_N_SIVC_LB_EMAIL, isBold: true),
            DescriptionText(text: vm.emailMessage),
          ],
          textField: CommonTextField(
            placeHolder: I18N.L_N_SIVC_TXTF_EMAIL,
            text: $vm.emailText),
          fieldStatus: vm.isFineEmail
        )
        
        InputField(
          labels: [
            DescriptionText(text: I18N.L_N_SIVC_LB_NICK, isBold: true),
            DescriptionText(text: I18N.L_N_SIVC_LB_NICK_DESC),
            DescriptionText(text: vm.nicknameMessage),
          ],
          textField: CommonTextField(
            placeHolder: I18N.L_N_SIVC_TXTF_NICK,
            text: $vm.nicknameText),
          fieldStatus: vm.isFineNickname
        )
        
        CommonButton(buttonTitle: I18N.L_N_SIVC_BTN_CONF) {
          vm.registerUser()
        }
        .alert(
          vm.alertType.getTitle(),
          isPresented: $vm.showAlert,
          presenting: vm.alertType,
          actions: { alertType in
            Button {
              vm.showAlert = false
            } label: {
              Text("확인")
            }
          }, message: { alertType in
            Text(alertType.getMessage())
          }
        )
        .padding(16)
      }
    }
#if targetEnvironment(macCatalyst)
    .padding()
#endif
  }
  
  struct InputField: View {
    let labels: [DescriptionText]
    let textField: CommonTextField
    let fieldStatus: Bool
    
    @State var isFineText = false
    
    init(
      labels: [DescriptionText],
      textField: CommonTextField,
      fieldStatus: Bool
    ) {
      self.labels = labels
      self.textField = textField
      self.fieldStatus = fieldStatus
    }
    
    var body: some View {
      HStack(alignment: .top, spacing: 0) {
        Circle()
          .foregroundColor(fieldStatus ? .blue : .red)
          .frame(width: 8,height: 8)
        .padding(4)
        VStack(alignment: .leading, spacing: 4) {
          ForEach(labels) { label in
            label
          }
          
          textField
        }
        .padding(.trailing, 16)
      }
    }
  }
  
  struct DescriptionText: View, Identifiable {
    var id: UUID = .init()
    
    private let text: String
    private let isBold: Bool
    
    private var customFont: UIFont {
      isBold
      ? UIFont.boldSystemFont(ofSize: 15)
      : UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    init(
      text: String,
      isBold: Bool = false
    ) {
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
