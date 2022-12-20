//
//  IssueTrackerApp.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/19.
//

import SwiftUI

@main
struct IssueTrackerApp: App {
  
  let user: UserState = .init()
  let app: AppState = .init()
  
  @ViewBuilder
  var body: some Scene {
    WindowGroup {
      HomeView()
        .environmentObject(user)
        .environmentObject(app)
    }
  }
}
