//
//  SettingListView.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/30.
//

import SwiftUI

struct SettingListView: View {
  
  @EnvironmentObject
  var appState: AppState
  
  var body: some View {
    ScrollView {
      VStack {
        Text("Hello, Settings!")
        
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
}

struct SettingListView_Previews: PreviewProvider {
  static var previews: some View {
    SettingListView()
  }
}
