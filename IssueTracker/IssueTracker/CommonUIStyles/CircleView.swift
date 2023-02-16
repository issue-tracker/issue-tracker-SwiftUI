//
//  CircleView.swift
//  IssueTracker
//
//  Created by 백상휘 on 2023/02/16.
//

import SwiftUI

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

struct CircleView_Previews: PreviewProvider {
  static var previews: some View {
    CircleView(timer: .constant(nil), status: .constant(.fine))
  }
}
