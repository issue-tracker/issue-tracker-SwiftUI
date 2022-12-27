//
//  LoginView.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/19.
//

import SwiftUI

/// V
struct LoginView: View {
  
  @State var idTextValue: String = ""
  @State var passwordTextValue: String = ""
  
  @EnvironmentObject
  var userState: UserState
  
  var body: some View {
    NavigationView {
      VStack(spacing: spacing) {
        Spacer()
        CommonTextField(
          capImage: idTextValue.count > 0 ? Image.personWave2Fill : Image.personFill,
          placeHolder: I18N.L_N_LVC_TXTF_ID,
          text: $idTextValue)
        
        CommonTextField(
          capImage: passwordTextValue.count > 0 ? Image.lockOpen : Image.lock,
          placeHolder: I18N.L_N_LVC_TXTF_PW,
          text: $passwordTextValue)
        
        CommonButton(
          buttonTitle: I18N.L_N_LVC_BTN_LOGIN,
          actionHandler: {
            userState.isLogin = true
          })
        .loginShadow()
        
        HStack(alignment: .center, spacing: spacing) {
          Button(action: {
            
          }) {
            Text(I18N.L_N_LVC_BTN_PWRESET)
              .font(.footnote)
              .foregroundColor(.gray)
              .padding(.top)
          }
          
          Spacer()
          
          NavigationLink(destination: {
            SignInView()
          }, label: {
            Text(I18N.L_N_LVC_BTN_SIGNIN)
          })
        }
        .padding(EdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 32))
        
        Button(
          action: { },
          label: {
            Text(I18N.L_N_LVC_BTN_SIGNIN_OAUTH)
              .font(.title2)
              .foregroundColor(.gray)
          })
        
        HStack(spacing: spacing) {
          Button(action: {
            
          }) {
            ButtonImage(imageName: "login_octocat")
          }
          Button(action: {
            
          }) {
            ButtonImage(imageName: "login_icon_kakao")
          }
          Button(action: {
            
          }) {
            ButtonImage(imageName: "login_icon_naver")
          }
        }
        .frame(height: 60)
      } // end of VStack
      .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
    } // end of NavigationView
  } // end of LoginView body
  
  struct ButtonImage: View {
    let imageName: String
    
    var body: some View {
      Image(imageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .shadow(radius: 0, x: 2, y: 2)
    } // end of ButtonImage body
  }
}

extension View {
  func loginShadow() -> some View {
    self
      .shadow(
        color: .gray,
        radius: spacing/2,
        x: spacing/2, y: spacing/2)
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
