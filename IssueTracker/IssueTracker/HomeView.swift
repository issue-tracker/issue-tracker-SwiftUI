//
//  HomeView.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/20.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject
  var userState: UserState
  @EnvironmentObject
  var appState: AppState
  
  @ViewBuilder
  var body: some View {
    if userState.isLogin {
      MainContentsTabView()
        .preferredColorScheme($appState.appearance.toColorScheme())
    } else {
      LoginView()
        .preferredColorScheme($appState.appearance.toColorScheme())
    }
  }
}

extension Binding where Value == AppAppearance {
  func toColorScheme() -> ColorScheme? {
    switch self.wrappedValue {
    case .light:
      return ColorScheme.light
    case .dark:
      return ColorScheme.dark
    case .automatic:
      return nil
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .environmentObject(UserState())
      .environmentObject(AppState())
  }
}
