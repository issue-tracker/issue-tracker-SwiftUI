//
//  MainView.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/20.
//

import SwiftUI

struct MainView: View {
  
  @EnvironmentObject
  var appState: AppState
  
  var body: some View {
    VStack {
      Text("Hello, MainView!")
      
      Picker("", selection: $appState.appearance) {
        ForEach(AppAppearance.allCases) { appearance in
          Text(appearance.name)
            .tag(appearance)
        }
      }
      .pickerStyle(SegmentedPickerStyle())
    }
    .padding(.horizontal)
  }
}

struct MainView_Previews: PreviewProvider {
  
  static let user = UserState()
  static let app = AppState()
  
  static var previews: some View {
    MainView()
      .environmentObject(user)
      .environmentObject(app)
  }
}
