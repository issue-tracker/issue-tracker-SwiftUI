//
//  SignInView.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/21.
//

import SwiftUI

struct SignInView: View {
  @ObservedObject var vm = SignInViewModel()
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ScrollView {
      VStack(spacing: 15) {
        HStack(alignment: .top) {
          CircleView(
            timer: $vm.idTimer,
            status: $vm.idStatus)
          InputField(
            labels: [
              DescriptionText(text: I18N.L_N_SIVC_LB_ID, isBold: true),
              DescriptionText(text: I18N.L_N_SIVC_LB_ID_DESC),
              DescriptionText(text: vm.idMessage),
            ],
            textField: CommonTextField(
              placeHolder: I18N.L_N_SIVC_TXTF_ID,
              text: $vm.idText)
          )
        }
        
        HStack(alignment: .top) {
          CircleView(
            timer: .constant(nil),
            status: $vm.pwStatus)
          InputField(
            labels: [
              DescriptionText(text: I18N.L_N_SIVC_LB_PW, isBold: true),
              DescriptionText(text: I18N.L_N_SIVC_LB_PW_DESC),
              DescriptionText(text: vm.pwMessage),
            ],
            textField: CommonTextField(
              isSecure: true,
              placeHolder: I18N.L_N_SIVC_TXTF_PW,
              text: $vm.pwText)
          )
        }
        
        HStack(alignment: .top) {
          CircleView(
            timer: .constant(nil),
            status: $vm.pwConfirmedStatus)
          InputField(
            labels: [
              DescriptionText(text: I18N.L_N_SIVC_LB_PW_CONF, isBold: true),
              DescriptionText(text: vm.pwConfirmedMessage),
            ],
            textField: CommonTextField(
              isSecure: true,
              placeHolder: I18N.L_N_SIVC_TXTF_PW_CONF,
              text: $vm.pwConfirmText)
          )
        }
        
        HStack(alignment: .top) {
          CircleView(
            timer: $vm.emailTimer,
            status: $vm.emailStatus)
          InputField(
            labels: [
              DescriptionText(text: I18N.L_N_SIVC_LB_EMAIL, isBold: true),
              DescriptionText(text: vm.emailMessage),
            ],
            textField: CommonTextField(
              placeHolder: I18N.L_N_SIVC_TXTF_EMAIL,
              text: $vm.emailText)
          )
        }
        
        HStack(alignment: .top) {
          CircleView(
            timer: $vm.nicknameTimer,
            status: $vm.nicknameStatus)
          InputField(
            labels: [
              DescriptionText(text: I18N.L_N_SIVC_LB_NICK, isBold: true),
              DescriptionText(text: I18N.L_N_SIVC_LB_NICK_DESC),
              DescriptionText(text: vm.nicknameMessage),
            ],
            textField: CommonTextField(
              placeHolder: I18N.L_N_SIVC_TXTF_NICK,
              text: $vm.nicknameText)
          )
        }
        
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
              if vm.alertType == .confirm {
                dismiss()
              }
            } label: {
              Text("확인")
            }
          }, message: { alertType in
            Text(alertType.getMessage())
          }
        )
        .padding(16)
      } // end of VStack
    } // end of ScrollView
#if targetEnvironment(macCatalyst)
    .padding()
#endif
  } // end of body
}

struct SignInView_Previews: PreviewProvider {
  static var previews: some View {
    SignInView()
  }
}
