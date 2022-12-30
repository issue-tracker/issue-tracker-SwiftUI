//
//  MainContentsTabView.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/30.
//

import SwiftUI

struct MainContentsTabView: View {
  
  @EnvironmentObject
  var appState: AppState
  
  var body: some View {
    TabView {
      MainContentsListView()
        .tabItem({
          VStack {
            Image.listBullet
            Text("list")
          }
        })
        .tag(0)
      
      SettingListView()
        .tabItem({
          VStack {
            Image.gear
            Text("setting")
          }
        })
        .tag(1)
    }
  }
}

struct MainContentsTabView_Previews: PreviewProvider {
  static var previews: some View {
    MainContentsTabView()
  }
}
