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
  
  struct CircleView: View {
    @Binding var timer: Timer?
    @Binding var status: SignInViewModel.InputStatus
    
    var body: some View {
      VStack {
        if $timer.wrappedValue == nil {
          Circle()
            .foregroundColor($status.wrappedValue.getColor())
        } else {
          ProgressView()
        }
      }
      .frame(width: 8,height: 8)
      .padding(4)
    }
  }
}

struct SignInView_Previews: PreviewProvider {
  static var previews: some View {
    SignInView()
  }
}
